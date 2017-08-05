Pod::Spec.new do |s|
  s.name             = "InkKit"
  s.version          = "4.0.0"
  s.summary          = "Drawing and Geometry made easy on iOS - now in Swift 4.0"
  s.homepage         = "https://github.com/shaps80/InkKit"
  s.screenshots      = "https://camo.githubusercontent.com/3b91556602d4501e9916903939f35d1ea85697a7/687474703a2f2f73686170732e6d652f6173736574732f696d672f626c6f672f496e6b4b69742e676966"
  s.license          = 'MIT'
  s.author           = { "Shaps" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/InkKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platforms = { :ios => "8.0", :osx => "10.10" }
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*'
  s.dependency         'GraphicsRenderer'
end
