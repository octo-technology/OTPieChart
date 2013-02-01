Pod::Spec.new do |s|
  s.name         = "OTPieChart"
  s.version      = "1.0.0"
  s.summary      = "Pie Chart library"
  s.homepage     = "http://www.octo.com/"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Remy Virin" => "rvirin@octo.com", "Abdou Benhamouche" => "abenhamouche@octo.com" }
  s.source       = { :git => "https://github.com/octo-online/OTPieChart.git", :tag => s.version.to_s }
  s.platform     = :ios, '5.0'
  s.source_files = 'PieChart'
  s.requires_arc = true
  
  s.ios.frameworks = 'QuartzCore', 'CoreGraphics'
end

