# SHDataSources

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/Blackjacx/SHDataSources/blob/master/LICENSE) &nbsp;
![Version](http://cocoapod-badges.herokuapp.com/v/SHDataSources/badge.png) &nbsp;
![Platform](http://cocoapod-badges.herokuapp.com/p/SHDataSources/badge.png) &nbsp;

## Description

Project-independent, block-based data source for UITableView, UICollectionView and NSFetchedResultsController. This project helps to make view controllers much lighter. It is possible to add more than one section and to provide another cell identifier for every section. This makes it possible to use different UITableViewCell subclasses in a single UITableView.

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

This project supports the following types of data sources:

* `SHDataSource` - immutable and mutable data source that offers add, insert, delete and reorder arbitrary items.
* `SHEmptyDataSource` - returns zero sections, zero rows and zero cells. Can be used while waiting for the download of items.

The intended use is as follows (see also the example included in the repository):

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

## Installation

SHDataSources is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

pod "SHDataSources"

## ToDo's

* implement the possibility to set cell identifiers on a per item basis. That makes it possible to reorder different cell sub classes arbitrarily between sections
* extend the data source for the remaining data source methods of UITableView
* find a way to associate a cellIdentifier for every item in the data source
* insert comments for all methods, classes and protocols

## License

SHDataSources is available under the MIT license. See the LICENSE file for more info.

