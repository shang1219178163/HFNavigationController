#
# Be sure to run `pod lib lint HFNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HFNavigationController'
  s.version          = '1.4.2'
  s.summary          = "like Apple' signIn UX"
  s.description      = "like Apple' signIn UX..."

  s.homepage         = 'https://github.com/shang1219178163/HFNavigationController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shang1219178163' => 'shang1219178163@gmail.com' }
  s.source           = { :git => 'https://github.com/shang1219178163/HFNavigationController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = "5.0"
  s.requires_arc = true
  s.source_files = 'HFNavigationController/Classes/**/*'
  
  # s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage',
    # 'CoreLocation','CoreTelephony','QuartzCore', 'WebKit'
  # s.resource_bundles = {
  #   'HFNavigationController' => ['HFNavigationController/Assets/*.png']
  # }
  #
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
