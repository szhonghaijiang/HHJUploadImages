Pod::Spec.new do |s|
  s.name     = 'HHJUploadImages'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.author   = {'szulmj' => 'https://github.com/szhonghaijiang' }
  s.homepage = 'https://github.com/szhonghaijiang/HHJUploadImages'
  s.summary  = 'Show the big image from imageViews or images by swift'

  s.source   = { :git => 'https://github.com/szhonghaijiang/HHJUploadImages.git', :tag => '1.0.1'}
  s.source_files = 'HHJUploadImagesExample/HHJUploadImages', 'HHJUploadImagesExample/HHJUploadImages/*.swift'
  s.framework = 'UIKit', "Foundation"
  s.requires_arc = true
  s.platform = :ios
  s.ios.deployment_target = '8.0'

end
