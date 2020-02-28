Pod::Spec.new do |spec|
  spec.name         = "SwiftParamTest"
  spec.version      = "0.1.3"
  spec.summary      = "Parameterized test for Swift."

  spec.description  = <<-DESC
  Parameterized test for Swift with XCTest.
  DESC

  spec.homepage         = "https://github.com/YusukeHosonuma/SwiftParamTest"
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors          = { "Yusuke Hosonuma" => "tobi462@gmail.com" }
  spec.social_media_url = "https://twitter.com/tobi462"

  spec.ios.deployment_target     = "9.3"
  # spec.osx.deployment_target     = "9.3"
  # spec.watchos.deployment_target = "9.3"
  # spec.tvos.deployment_target    = "9.3"

  spec.source = { :git => "https://github.com/YusukeHosonuma/SwiftParamTest.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources/**/*.{swift}"

  spec.framework = "XCTest"
  spec.user_target_xcconfig = {
    'LIBRARY_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/usr/lib',
  }
  spec.pod_target_xcconfig = {
    'APPLICATION_EXTENSION_API_ONLY' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'OTHER_LDFLAGS' => '$(inherited) -Xlinker -no_application_extension -weak_framework XCTEST -weak-lXCTestSwiftSupport',
  }

  spec.swift_version = "5.1"
end
