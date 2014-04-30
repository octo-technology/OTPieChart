#
#  Be sure to run `pod spec lint OTPieChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "OTPieChart"
  s.version      = "1.0"
  s.summary      = "OTPieChart is pie chart made simple for iOS"

  s.description  = <<-DESC
			Did you ever dreamt to create really nice pie chart without the help of a good designer ?

			Dream is over. We made it with love, just for you !
                   DESC

  s.homepage     = "https://github.com/octo-online/OTPieChart"
  s.screenshots  = "https://raw.github.com/octo-online/OTPieChart/master/images/why.png"

  s.license      = { :type => "Apache", :file => "LICENSE" }

  s.author             = { "Stéphane Prohaszka" => "stephane.prohaszka@octo.com" }

  s.platform     = :ios

  s.ios.deployment_target = "6.0"

  s.source       = { :git => "http://EXAMPLE/OTPieChart.git", :tag => "1.0" }

  s.source_files  =  "PieChart/**/*.{h,m}"

  s.framework  = "QuartzCore"

  s.requires_arc = true

end
