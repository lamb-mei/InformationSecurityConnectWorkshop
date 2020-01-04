# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'InformationSecurityWorkshop' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for proxytest
  pod 'Alamofire'
  pod "PromiseKit", "~> 6.8"
  pod 'SwiftyRSA'
  pod 'CryptoSwift'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end
