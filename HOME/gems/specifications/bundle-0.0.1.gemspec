# -*- encoding: utf-8 -*-
# stub: bundle 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bundle".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Will Leinweber".freeze]
  s.date = "2011-03-30"
  s.description = "You really mean `gem install bundler`. It's okay. I'll fix it for you this one last time...".freeze
  s.email = "will@bitfission.com".freeze
  s.homepage = "http://gembundler.com".freeze
  s.rubygems_version = "2.7.6".freeze
  s.summary = "s/bundle/bundler".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bundler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
  end
end
