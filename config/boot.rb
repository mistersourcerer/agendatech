require 'rubygems'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

# new yaml engine don't like our old locale yamls, some bad format that
# syck doesn't care about, correct the yamls would be better than this.
YAML::ENGINE.yamler= 'syck' if defined?(YAML::ENGINE)
