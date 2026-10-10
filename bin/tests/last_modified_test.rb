require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
load File.expand_path('../last-modified', __dir__)

class LastModifiedTest < Minitest::Test
  SCRIPT = File.expand_path('../last-modified', __dir__)
  OLD = '2026-01-01T12:00:00Z'

  def setup
    @original = Dir.pwd
    @repo = Dir.mktmpdir('page-timestamps-')
    Dir.chdir(@repo)
    git('init', '-q')
    git('config', 'user.name', 'Timestamp tests')
    git('config', 'user.email', 'timestamps@example.invalid')
    git('config', 'core.hooksPath', '.git/hooks')
    write('index.md', page('Home'))
    write('donate.md', page('Donate', '{% include news.html %} {{ site.data.donations }}'))
    write('_includes/news.html', 'Original news')
    write('_data/donations.json', '{"total": 1}')
    write('_layouts/default.html', '{{ content }}')
    git('add', '.')
    git('commit', '-qm', 'Initial content')
  end

  def teardown
    Dir.chdir(@original)
    FileUtils.remove_entry(@repo)
  end

  def git(*args)
    LastModified.git(*args)
  end

  def write(path, content)
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, content)
  end

  def page(title, body = 'Original body', extra = '')
    "---\nlayout: default\ntitle: #{title}\nlast_modified_at: #{OLD}\n#{extra}---\n#{body}\n"
  end

  def run_hook
    output, error, status = Open3.capture3('ruby', SCRIPT, '--staged')
    assert status.success?, "#{output}\n#{error}"
  end

  def test_real_commit_preserves_partially_staged_content
    write('.git/hooks/pre-commit', "#!/bin/sh\nexec ruby '#{SCRIPT}' --staged\n")
    File.chmod(0o755, '.git/hooks/pre-commit')
    write('index.md', page('Home', 'Staged body'))
    git('add', 'index.md')
    write('index.md', page('Home', 'Staged body plus unstaged work'))
    git('commit', '-qm', 'Edit home')
    committed = git('show', 'HEAD:index.md')
    assert_includes committed, 'Staged body'
    refute_includes committed, 'unstaged work'
    assert_includes File.read('index.md'), 'unstaged work'
    assert_equal LastModified.timestamp(committed), LastModified.timestamp(File.read('index.md'))
    assert_equal '', git('diff', '--cached')
    assert LastModified.timestamp(committed) > Time.iso8601(OLD)
    LastModified.check('HEAD^', 'HEAD')
  end

  def test_shared_data_updates_consumer_but_does_not_stage_its_edits
    write('_data/donations.json', '{"total": 2}')
    git('add', '_data/donations.json')
    File.open('donate.md', 'a') { |f| f.puts 'Unstaged copy' }
    run_hook
    refute_includes git('show', ':donate.md'), 'Unstaged copy'
    assert_includes File.read('donate.md'), 'Unstaged copy'
    assert_equal Time.iso8601(OLD), LastModified.timestamp(git('show', ':index.md'))
    assert LastModified.timestamp(git('show', ':donate.md')) > Time.iso8601(OLD)
  end

  def test_commit_only_is_rejected_without_changing_either_index
    write('.git/hooks/pre-commit', "#!/bin/sh\nexec ruby '#{SCRIPT}' --staged\n")
    File.chmod(0o755, '.git/hooks/pre-commit')
    write('index.md', page('Home', 'Unrelated staged edit'))
    git('add', 'index.md')
    write('_data/donations.json', '{"total": 2}')
    staged = git('diff', '--cached')
    working = File.read('donate.md')
    error = assert_raises(RuntimeError) do
      git('commit', '--only', '-qm', 'Update donations', '--', '_data/donations.json')
    end
    assert_includes error.message, 'without file/path arguments'
    refute_includes git('show', 'HEAD:index.md'), 'Unrelated staged edit'
    assert_includes git('show', ':index.md'), 'Unrelated staged edit'
    assert_equal staged, git('diff', '--cached')
    assert_equal working, File.read('donate.md')
  end

  def test_nested_shared_content_updates_both_entry_points
    write('budget.md', page('Budget', '{% include season-content/budget.md %}', "season: '2026-2027'\n"))
    write('seasons/biobuzz/budget/index.md', page('Budget', '{% include season-content/budget.md %}', "budget_season: '2026-2027'\n"))
    write('_includes/season-content/budget.md', '{{ site.data.budgets[page.budget_season] }}')
    write('_data/budgets/2026-2027.json', '{}')
    git('add', '.')
    git('commit', '-qm', 'Shared content')
    write('_data/budgets/2026-2027.json', '{"total": 2}')
    git('add', '_data')
    run_hook
    %w[budget.md seasons/biobuzz/budget/index.md].each do |path|
      assert LastModified.timestamp(git('show', ":#{path}")) > Time.iso8601(OLD)
    end
  end

  def test_deleted_include_updates_consumer
    git('rm', '_includes/news.html')
    run_hook
    assert LastModified.timestamp(git('show', ':donate.md')) > Time.iso8601(OLD)
  end

  def test_layout_and_navigation_changes_leave_dates_unchanged
    write('_layouts/default.html', '<main>{{ content }}</main>')
    write('_data/navigation.yml', 'program: []')
    write('_includes/season-nav.html', '<nav>New season</nav>')
    git('add', '.')
    run_hook
    assert_equal Time.iso8601(OLD), LastModified.timestamp(git('show', ':index.md'))
    assert_equal Time.iso8601(OLD), LastModified.timestamp(git('show', ':donate.md'))
  end

  def test_timestamp_only_change_does_not_cascade
    write('index.md', LastModified.stamp(File.read('index.md'), '2026-02-01T12:00:00Z'))
    git('add', 'index.md')
    before = git('diff', '--cached')
    run_hook
    assert_equal before, git('diff', '--cached')
  end

  def test_new_page_gets_timestamp_and_renamed_page_is_supported
    write('new.md', "---\nlayout: default\n---\nNew page\n")
    git('mv', 'index.md', 'renamed.md')
    git('add', 'new.md')
    run_hook
    assert LastModified.timestamp(git('show', ':new.md'))
    assert LastModified.timestamp(git('show', ':renamed.md')) > Time.iso8601(OLD)
  end

  def test_season_change_updates_old_and_new_blog_listings
    write('seasons/a/blog/index.md', page('A', '{% include season-posts.html %}', "season: a\n"))
    write('seasons/b/blog/index.md', page('B', '{% include season-posts.html %}', "season: b\n"))
    write('_includes/season-posts.html', "{% assign posts = site.posts | where: 'season', page.season %}")
    write('_posts/2026-01-01-post.md', page('Post', 'Hello', "season: a\n"))
    git('add', '.')
    git('commit', '-qm', 'Add listings')
    write('_posts/2026-01-01-post.md', page('Post', 'Hello', "season: b\n"))
    git('add', '_posts')
    run_hook
    %w[a b].each do |season|
      assert LastModified.timestamp(git('show', ":seasons/#{season}/blog/index.md")) > Time.iso8601(OLD)
    end
  end

  def test_budget_data_is_season_specific
    %w[2025-2026 2026-2027].each do |season|
      write("#{season}.md", page(season, '{{ site.data.budgets[page.budget_season] }}', "budget_season: '#{season}'\n"))
      write("_data/budgets/#{season}.json", '{}')
    end
    git('add', '.')
    git('commit', '-qm', 'Add budgets')
    write('_data/budgets/2026-2027.json', '{"updated": "2026-10-10"}')
    git('add', '_data')
    run_hook
    assert_equal Time.iso8601(OLD), LastModified.timestamp(git('show', ':2025-2026.md'))
    assert LastModified.timestamp(git('show', ':2026-2027.md')) > Time.iso8601(OLD)
  end

  def test_ci_catches_bypassed_hook_and_supports_repair
    write('_includes/news.html', 'New news')
    git('add', '.')
    git('commit', '-qm', 'Bypass hook')
    error = assert_raises(RuntimeError) { LastModified.check('HEAD^', 'HEAD') }
    assert_includes error.message, 'donate.md: content changed'
    LastModified.update_index('HEAD^')
    git('commit', '-qm', 'Repair timestamp')
    LastModified.check('HEAD~2', 'HEAD')
  end

  def test_ci_rejects_missing_timestamp
    write('index.md', LastModified.without_stamp(File.read('index.md')))
    git('add', '.')
    git('commit', '-qm', 'Remove timestamp')
    assert_raises(RuntimeError) { LastModified.check('HEAD^', 'HEAD') }
  end

  def test_missing_working_file_aborts_before_any_mutation
    write('_includes/news.html', 'New news')
    git('add', '.')
    File.delete('donate.md')
    before = git('diff', '--cached')
    assert_raises(RuntimeError) { LastModified.update_index }
    assert_equal before, git('diff', '--cached')
  end

  def test_backfill_uses_history_and_is_idempotent
    write('index.md', LastModified.without_stamp(File.read('index.md')))
    git('add', '.')
    git('commit', '-qm', 'Page without timestamp')
    expected = git('log', '-1', '--format=%cI', '--', 'index.md').strip
    LastModified.backfill
    assert_equal Time.iso8601(expected), LastModified.timestamp(File.read('index.md'))
    before = File.read('index.md')
    LastModified.backfill
    assert_equal before, File.read('index.md')
    assert_equal '', git('diff', '--cached')
  end

  def test_backfill_initializes_untracked_pages_without_staging_them
    write('new.md', "---\nlayout: default\n---\nNew page\n")
    LastModified.backfill
    assert LastModified.timestamp(File.read('new.md'))
    assert_equal '', git('diff', '--cached')
    assert_includes git('ls-files', '--others', '--exclude-standard'), 'new.md'
  end

  def test_flyer_versions_and_body_examples_are_preserved
    source = page('Conduct', "last_modified_at: body example\n", "version: '1.0'\ndocument_date: 2026-01-01\n")
    updated = LastModified.stamp(source, '2026-10-10T12:00:00Z')
    assert_includes updated, 'last_modified_at: body example'
    assert_includes updated, "version: '1.0'"
    assert_includes updated, 'document_date: 2026-01-01'
    write('flyer.md', "---\nlayout: flier\nversion: '1.0'\n---\nFlyer")
    git('add', '.')
    run_hook
    refute_includes git('show', ':flyer.md'), 'last_modified_at'
  end
end
