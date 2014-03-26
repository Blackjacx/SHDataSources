# SHDataSources

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/Blackjacx/SHDataSources/blob/master/LICENSE) &nbsp;
![Version](http://cocoapod-badges.herokuapp.com/v/SHDataSources/badge.png) &nbsp;
![Platform](http://cocoapod-badges.herokuapp.com/p/SHDataSources/badge.png) &nbsp;

## Description

Project-independent, block-based data sources for UITableView and UICollectionView.

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

This project supports the following types of data sources:

* `SHArrayDataSource` - immutable data source for static content
* `SHMutableArrayDataSource` - editable, movable and offers methods for adding, inserting and deleting objects.
* `SHEmptyDataSource` - returns no zero sections, zero rows and no cells. 

You can use the array data sources as follows:

``` objective-c
@interface MyCustomClass()
[...]
@property(nonatomic, strong)SHMutableArrayDataSource *mutableDataSource;
[...]
@end

self.mutableDataSource = [[SHMutableArrayDataSource alloc] initWithItems:itemList cellIdentifier:@"CELL_ID" configureCellWithItemBlock:^(MyCustomCellObject *cell, MyCustomItemObject *item) {
    // Configure the cell with the item
}];
```

## Requirements

## Installation

SHDataSources is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "SHDataSources"

## ToDo's

* handling of different CellIdentifiers and UITableViewCellSubtypes for certain NSIndexPaths. Sometines you want special cell types for some NSIndexPaths.

## License

SHDataSources is available under the MIT license. See the LICENSE file for more info.

