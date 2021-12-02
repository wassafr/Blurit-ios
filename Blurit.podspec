Pod::Spec.new do |spec|
  spec.name             = "Blurit"
  spec.version          = "1.0.1"
  spec.summary          = "Blurit is an SDK to anonymize pictures and videos containing faces and car plates."
  spec.description      = <<-DESC
Blurit is able to track multiple faces and then detect gender and age for each detected face.
DESC

  spec.homepage         = "https://Blurit.io"
  spec.license          = { :type => 'COMMERCIAL', :file => 'LICENSE.md'}
  
  spec.author           = { "Wassa" => "contact@wassa.io" }

  spec.source           = { :http => 'https://github.com/wassafr/Blurit-ios/raw/master/Blurit_SDK.zip'}
  #spec.source           = { :http => 'file:' + __dir__ + '/Blurit_SDK.zip' }

  spec.platform          = :ios, '13.0'
  spec.swift_versions    = '5.4'
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  spec.ios.vendored_frameworks = 'Blurit_SDK.xcframework'
  spec.frameworks = 'Blurit_SDK'

end
