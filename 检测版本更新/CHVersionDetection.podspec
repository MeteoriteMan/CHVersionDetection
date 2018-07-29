Pod::Spec.new do |s|
    s.name         = "CHVersionDetection"
    s.version      = "0.0.1"
    s.summary      = "You can Use CHVersionDetection to Detection App version"
    s.homepage     = "https://github.com/MeteoriteMan/ZCHVersionDetection"
    s.license      = "MIT"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "张晨晖" => "shdows007@gmail.com" }
    s.platform     = :ios
    s.source       = { :git => "https://github.com/MeteoriteMan/ZCHVersionDetection.git", :tag => s.version }
    s.source_files = 'ZCHVersionDetection/**/*.{h,m}'
    s.frameworks   = 'Foundation'
end