Pod::Spec.new do |s|
  s.name             = 'RxApolloClient'
  s.version          = '0.1.0'
  s.summary          = 'Rx wrapper of Apollo Client'
  s.description      = <<-DESC
  RxSwift extensions for Apollo Client
  DESC
  
  s.homepage         = 'https://github.com/OhKanghoon/RxApolloClient'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OhKanghoon' => 'ggaa96@naver.com' }
  s.source           = { :git => 'https://github.com/OhKanghoon/RxApolloClient.git', :tag => s.version.to_s }

  s.cocoapods_version = '>= 1.4.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'RxApolloClient/Classes/**/*'
  
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'Apollo', '~> 0.9.4'
end
