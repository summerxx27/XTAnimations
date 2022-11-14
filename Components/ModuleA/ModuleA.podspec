Pod::Spec.new do |s|

  s.name          = "ModuleA"
  s.version       = "0.0.1"
  s.summary       = "ModuleA"

  s.description   = <<-DESC

模块 A

DESC

  s.homepage      = "summerxx.com"
  s.author        = { "summerxx" => "summerxx.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "" }

  s.resource_bundle = {
    'DJMine' => ['Resources/*']
  }
  
  s.dependency 'SnapKit'

  s.source_files  = "Classes/DJMineModule.{h,m}", "Classes/MineModule.swift"

  s.private_header_files = "Classes/DJMineModule.h"

  s.subspec 'Core' do |ss|
    ss.source_files = "Classes/Core/**/*.{swift}"
  end

end
