# SHDataSources

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](http://opensource.org/licenses/MIT)
[![Version](http://cocoapod-badges.herokuapp.com/v/SHDataSources/badge.png)](http://cocoadocs.org/docsets/SHDataSources)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHDataSources/badge.png)](http://cocoadocs.org/docsets/SHDataSources)

## Description

Project-independent, block-based data source for UITableView, UICollectionView and NSFetchedResultsController. This project helps to make view controllers much lighter. It is possible to add more than one section and to provide another cell identifier for every section. This makes it possible to use different UITableViewCell subclasses in a single UITableView.

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first or just use the SHDataSources.xcworkspace file and build the SHDataSourceDemo scheme.

This project supports the following types of data sources:

* `SHDataSource` - immutable and mutable data source that offers add, insert, delete and reorder arbitrary items.
* `SHEmptyDataSource` - returns zero sections, zero rows and zero cells. Can be used while waiting for the download of items.

The intended use is as follows:

``` objective-c
@interface MyCustomClass()
[...]
@property(nonatomic, strong)SHDataSource *dataSource;
[...]
@end

SHItemCollection *collection = [[SHItemCollection alloc] initWithItems:@[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]] @"CELL_ID"];

self.dataSource = [SHDataSource dataSourceWithItemCollection:collection cellConfigurationHandler:^(id <SHDataSourcesCellDataHandler> cell, id item, NSIndexPath *indexPath) {
[cell setData:item];
}];

self.dataSource.editable = YES;
self.dataSource.draggingEnabled = YES;

self.tableView.dataSource = self.dataSource;
```

For a detailled example see the demo project included in the repository.

## Installation

SHDataSources is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

	pod "SHDataSources"

## ToDo's

* add a core data model and use this in the demo view controller. 
* Be shure to delete the contents of the DB on every app start to start the demo from the beginning all the time. 
* Implement create, delete and insert using core data in ItemCollection
* ...
* make an example for UICollectionView.
* implement data source for NSFetchedResultsController.
* extend the data source for the remaining data source methods of UITableView.
* insert comments for all methods, classes and protocols.

## License

SHDataSources is available under the MIT license. See the [LICENSE](http://opensource.org/licenses/MIT) for more info.

