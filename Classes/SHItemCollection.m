//
//  SHItemCollection.m
//  SHDataSources
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHItemCollection.h"

NSString *const SHDataSourceDefaultCellIdentifier = @"SHDataSourceDefaultCellIdentifier";

@interface SHItemCollection ()
@property(nonatomic, strong)NSArray *itemCollection;	// nested array
@property(nonatomic, strong)NSArray *cellIdentifiers;	// usual array
@end

@implementation SHItemCollection

- (id)init {
	return [self initWithItems:@[] cellIdentifier:SHDataSourceDefaultCellIdentifier];
}

- (instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier {
	if((self = [super init])) {
		if(items && cellIdentifier) {
			_itemCollection = @[items];
			_cellIdentifiers = @[cellIdentifier];
		}
	}
	return self;
}

- (void)addItems:(NSArray*)items toSection:(NSUInteger)section cellIdentifier:(NSString*)cellIdentifier {
	NSUInteger row = [self rowCountForSection:section];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	[self insertItems:items atIndexPath:indexPath withCellIdentifier:cellIdentifier];
}

- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier {
	NSUInteger section = indexPath.section;
	NSUInteger row = indexPath.row;
	NSArray * sectionItems = section < self.itemCollection.count ? self.itemCollection[section] : @[];

	NSMutableArray * updatedItems = [sectionItems mutableCopy];
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(( row <= sectionItems.count ? row : sectionItems.count ), items.count)];
	[updatedItems insertObjects:items atIndexes:indexSet];

	NSMutableArray *mutableItemCollection = [self.itemCollection mutableCopy];
	NSMutableArray *mutableCellIdentifiers = [self.cellIdentifiers mutableCopy];
	
	if(section < mutableItemCollection.count) {
		[mutableItemCollection replaceObjectAtIndex:section withObject:updatedItems];
		[mutableCellIdentifiers replaceObjectAtIndex:section withObject:cellIdentifier];
	} else {
		[mutableItemCollection addObject:updatedItems];
		[mutableCellIdentifiers addObject:cellIdentifier];
	}
	self.itemCollection = [mutableItemCollection copy];
	self.cellIdentifiers = [mutableCellIdentifiers copy];
}

- (void)removeItems:(NSArray*)items fromSection:(NSUInteger)section {
	if(section >= self.itemCollection.count) { return; }
	
	NSArray * existingItems = self.itemCollection[section];
	NSMutableArray * updatedItems = [existingItems mutableCopy];
	[updatedItems removeObjectsInArray:items];
	
	NSMutableArray *mutableItemCollection = [self.itemCollection mutableCopy];
	[mutableItemCollection replaceObjectAtIndex:section withObject:updatedItems];
	
	self.itemCollection = [mutableItemCollection copy];
}

- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath {
	return self.cellIdentifiers[indexPath.section];
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
	return self.itemCollection[indexPath.section][indexPath.row];
}

- (NSInteger)sectionCount {
	return self.itemCollection.count;
}

- (NSInteger)rowCountForSection:(NSUInteger)section {
	return section < self.itemCollection.count ? [self.itemCollection[section] count] : 0;
}

@end
