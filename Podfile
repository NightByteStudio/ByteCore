# Uncomment the next line to define a global platform for your project
platform :ios, '16.4'

def dependency_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya', '~> 15.0'
  pod 'Moya/RxSwift', '~> 15.0'
  pod 'RealmSwift', '~>10'
end

def test_pods
  pod 'Nimble'
  pod 'RxBlocking'
end

target 'ByteCore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ByteCore
  dependency_pods

  target 'ByteCoreTests' do
    inherit! :search_paths
    # Pods for testing
    dependency_pods
    test_pods
  end

  target 'ByteCoreUITests' do
    # Pods for testing
  end

end
