






# This pod is not published on trunk yet. You can use it by adding this to your podfile:
# pod 'VWWPermissionKit', :podspec => "https://raw.githubusercontent.com/zakkhoyt/VWWPermissionKit/0.0.1/VWWPermissionKit.podspec"

Pod::Spec.new do |s|
  s.name         = "VWWPermissionKit"
  s.version      = "0.0.1"
  s.summary      = "A permission manager for iOS"
  s.author        = { "Zakk Hoyt" => "vaporwarewolf@gmail.com" }
  s.homepage      = "http://github.com/zakkhoyt"
  s.license = { :type => 'MIT',
                :text =>  <<-LICENSE
                  Copyright 2015. Zakk hoyt.
                          LICENSE
              }
  s.source       = { :git => 'https://github.com/zakkhoyt/VWWPermissionKit.git',
                    :tag =>  "#{s.version}" }
  s.source_files  = 'VWWPermissionKit/VWWPermissionKit/**/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

end
