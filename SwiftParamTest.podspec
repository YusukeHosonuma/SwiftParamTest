#
# Be sure to run `pod lib lint SwiftParamTest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftParamTest'
  s.version          = '0.1.0'
  s.summary          = 'Parameterized test for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Parameterized test for Swift with XCTest.
                       DESC

  s.homepage         = 'https://github.com/YusukeHosonuma/SwiftParamTest'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yusuke Hosonuma' => 'tobi462@gmail.com' }
  s.source           = { :git => 'https://github.com/YusukeHosonuma/SwiftParamTest.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tobi462'

  s.ios.deployment_target = '9.3'

  s.source_files = 'SwiftParamTest/Classes/**/*'

  # s.resource_bundles = {
  #   'SwiftParamTest' => ['SwiftParamTest/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'XCTest', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.swift_version = '4.2'
end
