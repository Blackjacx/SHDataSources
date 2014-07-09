//
//  SHItemCollection.m
//  SHDataSources
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHItemCollection.h"
#import "NSObject+SHCellID.h"

NSString *const SHDataSourceDefaultCellIdentifier = @"SHDataSourceDefaultCellIdentifier";

@interface SHItemCollection ()
@property(nonatomic, strong)NSArray *itemCollection;	// nested array
@end

@implementation SHItemCollection

- (id)init {
	return [self initWithItems:@[] cellIdentifier:SHDataSourceDefaultCellIdentifier];
}

- (instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier {
	if((self = [super init])) {
		_itemCollection = @[items];
		[self SH_associateCellIdentifier:cellIdentifier toItems:_itemCollection];
	}
	return self;
}

- (void)addItems:(NSArray*)items toSection:(NSUInteger)section withCellIdentifier:(NSString*)cellIdentifier {
	NSUInteger row = [self rowCountForSection:section];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	[self insertItems:items atIndexPath:indexPath withCellIdentifier:cellIdentifier];
}

- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier {
	[self SH_associateCellIdentifier:cellIdentifier toItems:items];
	
	NSUInteger section = indexPath.section;
	NSUInteger row = indexPath.row;
	NSArray * sectionItems = section < self.itemCollection.count ? self.itemCollection[section] : @[];

	NSMutableArray * updatedItems = [sectionItems mutableCopy];
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(( row <= sectionItems.count ? row : sectionItems.count ), items.count)];
	[updatedItems insertObjects:items atIndexes:indexSet];

	NSMutableArray *mutableItemCollection = [self.itemCollection mutableCopy];
	
	if(section < mutableItemCollection.count) {
		[mutableItemCollection replaceObjectAtIndex:section withObject:updatedItems];
	} else {
		[mutableItemCollection addObject:updatedItems];
	}
	self.itemCollection = [mutableItemCollection copy];
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
	id item = [self itemAtIndexPath:indexPath];
	NSString *cellIdentifier = [item associatedCellIdentifer];
	return cellIdentifier;
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


#pragma mark -
#pragma mark Cell Identifiers (Private)


- (void)SH_associateCellIdentifier:(NSString *)cellIdentifier toItems:(NSArray *)items {
	for (id item in items) {
		if ([item isKindOfClass:[NSArray class]]) {
			for (id nestedItem in item) {
				[nestedItem setAssociatedCellIdentifer:cellIdentifier];
			}
		} else {
			[item setAssociatedCellIdentifer:cellIdentifier];
		}
	}
}

@end
