# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "cinch-quotes"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Caitlin Woodward"]
  s.email       = ["caitlin@caitlinwoodward.me"]
  s.homepage    = "https://github.com/caitlin/cinch-quotes"
  s.summary     = %q{Gives Cinch IRC bots ability to manage quotes}
  s.description = %q{Gives Cinch IRC bots ability to manage quotes}

  s.add_dependency("cinch", "~> 2.0")

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end