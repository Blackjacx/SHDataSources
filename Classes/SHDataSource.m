//
//  SHDataSource.m
//  SHDataSources
//
//  Created by Stefan Herold on 20/03/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHDataSource.h"
#import "SHDataSource_Protected.h"
#import "NSObject+SHCellID.h"
#import "SHItemCollection.h"

NSString *const SHDataSourceInsertedItemNotification = @"SHDataSourceInsertedItemNotification";
NSString *const SHDataSourceDeletedItemNotification = @"SHDataSourceDeletedItemNotification";
NSString *const SHDataSourceMovedItemNotification = @"SHDataSourceMovedItemNotification";

@implementation SHDataSource

- (id)init {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

+ (instancetype)dataSourceWithItemCollection:(SHItemCollection*)itemCollection cellConfigurationHandler:(SHDataSourceCellConfigurationHandler)cellConfigurationHandler {
	SHDataSource *instance = [[SHDataSource alloc] initWithItemCollection:itemCollection cellConfigurationHandler:cellConfigurationHandler];
	return instance;
}

- (instancetype)initWithItemCollection:(SHItemCollection*)itemCollection cellConfigurationHandler:(SHDataSourceCellConfigurationHandler)cellConfigurationHandler {
	self = [super init];
	if (self) {
		_itemCollection = itemCollection;
		_cellConfigurationHandler = cellConfigurationHandler;
		_editable = NO;
		_draggingEnabled = NO;
	}
	return self;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
	return [self.itemCollection itemAtIndexPath:indexPath];
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath {
	return [self.itemCollection cellIdentifierForIndexPath:indexPath];
}

#pragma mark -
#pragma mark UITableView DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.itemCollection sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.itemCollection rowCountForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self itemAtIndexPath:indexPath];
	UITableViewCell *cell = nil;
	
	if(item) {
		NSString *cellID = [item associatedCellIdentifer];
		cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
		self.cellConfigurationHandler(cell, item, indexPath);
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return self.isEditable;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	id affectedItem = [self itemAtIndexPath:indexPath];
	switch (editingStyle) {
		case UITableViewCellEditingStyleInsert: {
			NSString *cellID = [self.itemCollection cellIdentifierForIndexPath:indexPath];
			[self insertItems:@[affectedItem] atIndexPath:indexPath withCellIdentifier:cellID];
			[tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[self postInsertedItemNotification];
		}
			break;

		case UITableViewCellEditingStyleDelete: {
			[self removeItems:@[affectedItem] fromSection:indexPath.section];
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[self postDeletedItemNotification];
		}
			break;

		case UITableViewCellEditingStyleNone: {
		}
			break;
			
	}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return self.isDraggingEnabled;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSLog(@"Move from (%ld, %ld) to (%ld, %ld)", (long)sourceIndexPath.section, (long)sourceIndexPath.row, (long)destinationIndexPath.section, (long)destinationIndexPath.row);
	id moveItem = [self.itemCollection itemAtIndexPath:sourceIndexPath];
	NSString *cellID = [self.itemCollection cellIdentifierForIndexPath:sourceIndexPath];
	[self removeItems:@[moveItem] fromSection:sourceIndexPath.section];
	[self insertItems:@[moveItem] atIndexPath:destinationIndexPath withCellIdentifier:cellID];
	[self postMovedItemNotification];
}

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//}
//
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//}


#pragma mark -
#pragma mark Notifications


- (void)postInsertedItemNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:SHDataSourceInsertedItemNotification object:self];
}

- (void)postDeletedItemNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:SHDataSourceDeletedItemNotification object:self];
}

- (void)postMovedItemNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:SHDataSourceMovedItemNotification object:self];
}


#pragma mark -
#pragma mark DataSourceModifiers


- (void)addItems:(NSArray*)items toSection:(NSUInteger)section cellIdentifier:(NSString*)cellIdentifier {
	NSAssert(self.editable, @"Data source must be editable to perform this selector!");
	if(!self.isEditable) { return; }
	[self.itemCollection addItems:items toSection:section withCellIdentifier:cellIdentifier];
}

- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier {
	NSAssert(self.editable, @"Data source must be editable to perform this selector!");
	if(!self.isEditable) { return; }
	[self.itemCollection insertItems:items atIndexPath:indexPath withCellIdentifier:cellIdentifier];
}

- (void)removeItems:(NSArray*)items fromSection:(NSUInteger)section {
	NSAssert(self.editable, @"Data source must be editable to perform this selector!");
	if(!self.isEditable) { return; }
	[self.itemCollection removeItems:items fromSection:section];
}


#pragma mark -
#pragma mark UICollectionView DataSource


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//	id item = [self itemAtIndexPath:indexPath];
//	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
//	self.configureCellWithItemBlock(cell, item);
//	return cell;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//	return self.items.count;
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//	return 1;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//	return nil;
//}

@end
