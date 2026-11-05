# Shared client for the FIRST Tech Challenge Events API
# (https://ftc-events.firstinspires.org/services/API).
#
# Credentials come from FTC_API_USERNAME and FTC_API_TOKEN in the environment or
# in the repository's .env file (ignored by Git). The API is free for
# non-commercial use; pages that show its data must link back to the API page.
require 'json'
require 'net/http'

module FtcApi
  BASE = 'https://ftc-api.firstinspires.org/v2.0'
  INFO_URL = 'https://ftc-events.firstinspires.org/services/API'

  def self.credentials
    env = {}
    dotenv = File.expand_path('../../.env', __dir__)
    if File.exist?(dotenv)
      File.foreach(dotenv) do |line|
        next if line.strip.empty? || line.lstrip.start_with?('#')

        key, value = line.split('=', 2)
        env[key.strip] = value.to_s.strip.delete_prefix('"').delete_suffix('"') if value
      end
    end
    user = ENV['FTC_API_USERNAME'] || env['FTC_API_USERNAME']
    token = ENV['FTC_API_TOKEN'] || env['FTC_API_TOKEN']
    if user.to_s.empty? || token.to_s.empty?
      abort "Set FTC_API_USERNAME and FTC_API_TOKEN in .env or the environment.\n" \
            "Register for a free token at #{INFO_URL}/register"
    end
    [user, token]
  end

  def self.get(path, params = {})
    user, token = credentials
    uri = URI("#{BASE}/#{path}")
    uri.query = URI.encode_www_form(params) unless params.empty?
    req = Net::HTTP::Get.new(uri, 'Accept' => 'application/json')
    req.basic_auth(user, token)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |http| http.request(req) }
    abort "FTC API #{uri.path} failed: #{res.code} #{res.message}" unless res.is_a?(Net::HTTPSuccess)
    JSON.parse(res.body)
  end
end
