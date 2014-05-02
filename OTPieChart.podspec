
Pod::Spec.new do |s|

  s.name         = "OTPieChart"
  s.version      = "1.0"
  s.summary      = "OTPieChart is pie chart made simple for iOS"

  s.description  = <<-DESC
			Did you ever dreamt to create really nice pie chart without the help of a good designer ?

			Dream is over. We made it with love from OCTO, just for you !
                   DESC

  s.homepage     = "https://github.com/octo-online/OTPieChart"
  s.screenshots  = "https://raw.github.com/octo-online/OTPieChart/master/images/why.png"

  s.license      = { :type => "Apache", :file => "LICENSE" }

  s.author             = { "Stéphane Prohaszka" => "sprohaszka@octo.com", "Remy Virin" => "rvirin@octo.com", "Cédric Pointel" => "cpointel@octo.com", "Olivier Martin" => "omartin@octo.com" }

  s.platform     = :ios

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/octo-online/OTPieChart.git", :tag => "1.0.0" }

  s.source_files  =  "PieChart/**/*.{h,m}"

  s.framework  = "QuartzCore"

  s.requires_arc = true

end
