  require 'i18n'

module DriveConnect; end;

dirname = File.dirname File.expand_path(__FILE__)

# RubyMotion has a hard time with `module Foo::Bar`
glob = [ File.join(dirname, 'drive_connect/constants.rb') ] | Dir["#{dirname}/drive_connect/**/*.rb"]

I18n.load_path += Dir["#{dirname}/drive_connect/locales/*.yml"]
I18n.enforce_available_locales = true

if defined? Motion::Project::Config
  require 'motion-require'
  Motion::Require.require_relative_enabled = true
  Motion::Require.all(glob)

  Motion::Project::App.setup do |app|
    glob.each { |file| app.exclude_from_detect_dependencies << file }
  end
else
  glob.each { |file| require(file) }
end
