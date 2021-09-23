#
# Be sure to run `pod lib lint HFNavigationController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HFNavigationController'
  s.version          = '1.4.3'
  s.summary          = "like Apple' signIn UX"
  s.description      = "like Apple' signIn UX...(HFNavigationController/HFViewController)"

  s.homepage         = 'https://github.com/shang1219178163/HFNavigationController'
  s.screenshots      = 'https://github.com/shang1219178163/HFNavigationController/blob/master/screenshots/HFNavigationController.gif?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shang1219178163' => 'shang1219178163@gmail.com' }
  s.source           = { :git => 'https://github.com/shang1219178163/HFNavigationController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = "5.0"
  s.requires_arc = true
  s.source_files = 'HFNavigationController/Classes/**/*'
  
end
