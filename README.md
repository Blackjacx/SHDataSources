# SHDataSources

Project-independent, block-based data sources for UITableView and UICollectionView.

[![Version](http://cocoapod-badges.herokuapp.com/v/SHDataSources/badge.png)](http://cocoadocs.org/docsets/SHDataSources)
[![Platform](http://cocoapod-badges.herokuapp.com/p/SHDataSources/badge.png)](http://cocoadocs.org/docsets/SHDataSources)

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

This project supports the following types of data sources:

* `SHArrayDataSource` - immutable data source for static content
* `SHMutableArrayDataSource` - editable, movable and offers methods for adding, inserting and deleting objects.
* `SHEmptyDataSource` - returns no zero sections, zero rows and no cells. 

You can use the array data sources as follows:
```
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

## License

SHDataSources is available under the MIT license. See the LICENSE file for more info.

