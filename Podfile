# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Blood Bank' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Blood Bank
pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'SVProgressHUD'
pod 'ChameleonFramework'
pod 'TextFieldEffects'
pod 'NVActivityIndicatorView'

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
end
end
end