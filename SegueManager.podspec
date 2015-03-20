Pod::Spec.new do |s|
  s.name         = "SegueManager"
  s.version      = "0.9.0"
  s.license      = "MIT"

  s.summary      = "Easy Storyboard segues in Swift"

  s.authors           = { "Tom Lokhorst" => "tom@lokhorst.eu" }
  s.social_media_url  = "https://twitter.com/tomlokhorst"
  s.homepage          = "https://github.com/tomlokhorst/SegueManager"

  s.source          = { :git => "https://github.com/tomlokhorst/SegueManager.git", :tag => s.version }
  s.requires_arc    = true

  s.subspec "iOS" do |ss|
    ss.source_files = "ios/SegueManager.swift"
    ss.ios.deployment_target = '8.0'
  end

  s.subspec "OSX" do |ss|
    ss.source_files = "osx/SegueManager.swift"
    ss.osx.deployment_target = '10.10'
  end

end
