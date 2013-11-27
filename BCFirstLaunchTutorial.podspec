Pod::Spec.new do |s|
  s.name     = 'BCFirstLaunchTutorial'
  s.version  = '0.1'
  s.platform = :osx, '10.9'
  s.license  = 'MIT'
  s.summary  = 'NSPopover-based solution to provide a first-launch guided tour for Cocoa Apps. Now comes with a launch window.'
  s.homepage = 'https://github.com/bertrand-caron/BCFirstLaunchTutorial'
  s.author   = { 'Bertrand Caron' => 'bertrand.fx.caron@gmail.com' }
  s.source   = { :git => 'https://github.com/bertrand-caron/BCFirstLaunchTutorial.git', :tag => '0.1' }
  s.source_files = 'BCFirstLaunchTutorial/*.{h,m}'
  s.preserve_paths  = 'Demo'
  s.requires_arc = true
end
