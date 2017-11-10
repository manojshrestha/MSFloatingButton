#
# Be sure to run `pod lib lint MSFloatingButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MSFloatingButton'
  s.version          = '0.1.2'
  s.summary          = 'Tumblr like floating button for iOS Projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Tumblr like floating button for iOS Projects. Mainly suitable for multiple floating button options. Shows floating buttons in another view in circular shape.
                       DESC

  s.homepage         = 'https://github.com/manojshrestha/MSFloatingButton'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manojshrestha' => 'iam.manojshrestha@gmail.com' }
  s.source           = { :git => 'https://github.com/manojshrestha/MSFloatingButton.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'MSFloatingButton/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MSFloatingButton' => ['MSFloatingButton/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit'
    s.dependency 'BubbleTransition', '~> 2.0.0'
    # s.dependency 'AFNetworking', '~> 2.3'
end
