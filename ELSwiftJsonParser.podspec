
Pod::Spec.new do |s|

  s.name         = "ELSwiftJsonParser"
  s.version      = "1.0.0"
  s.summary      = "A light-weight tool helps to transfrom Json dictionary into model as well as transfrom model into Json dictionary."
  s.description  = <<-DESC
  A light-weight tool helps to transfrom Json dictionary into model as well as transfrom model into Json dictionary.
                   DESC
  s.homepage     = "https://github.com/Elenionl/ELSwiftJsonParser"
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE.md' }
  s.author             = { "Hanping Xu" => "stellanxu@gmail.com" }
  s.social_media_url   = "https://github.com/Elenionl"
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/Elenionl/ELSwiftJsonParser.git", :tag => "#{s.version}" }
  s.source_files  = "ELSwiftJsonParser/*"
  s.requires_arc = true
  s.frameworks = 'Foundation'
  s.swift_version = 4.0
end
# pod spec lint ELSwiftJsonParser.podspec
# pod trunk push ELSwiftJsonParser.podspec