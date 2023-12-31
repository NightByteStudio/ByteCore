Pod::Spec.new do |s|
  s.name             = 'ByteCore'
  s.version          = '0.1.5'
  s.summary          = 'Cocoapods for Core components by NightByteStudio.'
 
  s.homepage         = 'https://github.com/NightByteStudio/ByteCore.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NightByteStudio' => 'nightbyte.studio@gmail.com' }
  s.source           = { :git => 'https://github.com/NightByteStudio/ByteCore.git', :tag => s.version.to_s }
  
  s.swift_versions   = '4.0'
  s.ios.deployment_target = '15.0'
  s.source_files = 'ByteCore/Sources/**/*.{swift}'
  
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'Moya'
  s.dependency 'Moya/RxSwift'
  s.dependency 'RealmSwift'
 
end
