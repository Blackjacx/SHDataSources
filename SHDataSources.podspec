Pod::Spec.new do |s|
  s.name                    = 'SHDataSources'
  s.version                 = '0.0.3'
  s.summary                 = 'Project-independent, block-based data source for UITableView, UICollectionView and NSFetchedResultsController.'
  s.homepage                = 'https://github.com/Blackjacx/SHDataSources'
  s.license                 = {:type => 'MIT'}
  s.authors                 = {'Stefan Herold' => 'stefan.herold@gmail.com'}
  s.source                  = {:git => 'https://github.com/Blackjacx/SHDataSources.git', :tag => s.version.to_s}

  s.platform                = :ios, '6.0'
  s.ios.deployment_target   = '6.0'
  s.requires_arc            = true

  s.source_files            = 'Classes'

  s.public_header_files     = 'Classes/**/*.h'
end
