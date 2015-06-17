
Pod::Spec.new do |s|
  s.name         = "VWWPermissionKit"
  s.version      = "1.0.0"
  s.summary      = "A visual permission manager for iOS"
  s.author        = { "Zakk Hoyt" => "vaporwarewolf@gmail.com" }
  s.homepage      = "http://github.com/zakkhoyt/VWWPermissionKit"
  s.license = { :type => 'MIT',
                :text =>  <<-LICENSE
                  Copyright 2015. Zakk hoyt.
                          LICENSE
              }
  s.source       = { :git => 'https://github.com/zakkhoyt/VWWPermissionKit.git',
                    :tag =>  "#{s.version}" }
  s.source_files  = 'VWWPermissionKit/**/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end
