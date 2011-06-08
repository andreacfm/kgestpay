# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = 'kgestpay'
  s.version = '0.1.1'
  s.summary = 'server to server implementation for gestpay gateway'
  s.description = 'server to server implementation for gestpay gateway'

  s.required_ruby_version     = '>= 1.9.2'
  s.required_rubygems_version = '>= 1.3.5'

  s.author            = 'kemen'
  s.email             = 'andrea.campolonghi@kemen.it'
  s.homepage          = 'https://github.com/kemen/KGestPay'
  s.rubyforge_project = 'kgestpay'

  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.require_paths = %w(lib)  
  
  s.add_dependency  "soap4r" 
end
