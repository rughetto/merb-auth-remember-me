require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "merb-auth-remember-me"
GEM_VERSION = "0.0.1"
AUTHOR = "Surasit Liangpornrattana"
EMAIL = "punneng@gmail.com"
HOMEPAGE = "https://github.com/PunNeng/pn-merb-auth-remember-me"
SUMMARY = "Merb plugin that provides remember me for merb-auth-slice-password"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-core', '>= 1.0')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

Spec::Rake::SpecTask.new do |t|
   t.warning = true
   t.spec_opts = ["--format", "specdoc", "--colour"]
   t.spec_files = Dir['spec/**/*_spec.rb'].sort   
end
