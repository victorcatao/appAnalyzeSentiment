# Uncomment this line to define a global platform for your project
platform :ios, '9.0'

# Comment this line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!
inhibit_all_warnings!

source 'https://github.com/CocoaPods/Specs.git'

def myPods
    pod 'Alamofire', '~> 4.5'
    pod 'SDWebImage', '~> 4.0'
    pod 'RxSwift', '~> 5.0'
    pod 'RxCocoa', '~> 5.0'
    pod 'SnapKit'
end


target 'AnalyzeSentiment' do
    myPods
end

target 'AnalyzeSentimentTests' do
    myPods

    pod 'Quick'
    pod 'Nimble'
end