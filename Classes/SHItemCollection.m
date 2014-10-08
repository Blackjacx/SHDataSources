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
@property(nonatomic, strong)NSFetchedResultsController *fetchedResultsController;
@end

@implementation SHItemCollection


// =================================================================================================
#pragma mark - Initialization
// =================================================================================================


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

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController cellIdentifier:(NSString*)cellIdentifier {
	if((self = [super init])) {
		_fetchedResultsController = fetchedResultsController;
		_fetchedResultsController.delegate = self;
		[_fetchedResultsController performFetch:NULL];
		[self SH_associateCellIdentifier:cellIdentifier toItems:_itemCollection];
	}
	return self;
}


// =================================================================================================
#pragma mark - Modifying Data Source
// =================================================================================================


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


// =================================================================================================
#pragma mark - Getting infomration from the Collection
// =================================================================================================


- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath {
	id item = [self itemAtIndexPath:indexPath];
	NSString *cellIdentifier = [item associatedCellIdentifer];
	return cellIdentifier;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
	if(self.fetchedResultsController) {
		return [self.fetchedResultsController objectAtIndexPath:indexPath];
	} else if(self.itemCollection) {
		return self.itemCollection[indexPath.section][indexPath.row];
	} else {
		NSAssert(NO, @"Either fetchedResultsController or itemCollection must be non nil!");
		return nil;
	}
}

- (NSInteger)sectionCount {
	if(self.fetchedResultsController) {
		return self.fetchedResultsController.sections.count;
	} else if (self.itemCollection) {
		return self.itemCollection.count;
	} else {
		NSAssert(NO, @"Either fetchedResultsController or itemCollection must be non nil!");
		return 0;
	}
}

- (NSInteger)rowCountForSection:(NSUInteger)sectionIndex {
	if(self.fetchedResultsController) {
		return sectionIndex < self.fetchedResultsController.sections.count ? ((id<NSFetchedResultsSectionInfo>)self.fetchedResultsController.sections[sectionIndex]).numberOfObjects : 0;
	} else if(self.itemCollection) {
		return sectionIndex < self.itemCollection.count ? [self.itemCollection[sectionIndex] count] : 0;
	} else {
		NSAssert(NO, @"Either fetchedResultsController or itemCollection must be non nil!");
		return 0;
	}
}


// =================================================================================================
#pragma mark - NSFetchedResultsControllerDelegate (Private)
// =================================================================================================


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	if([self.fetchedResultsControllerDelegate respondsToSelector:@selector(fetchedResultsController:didChangeObject:atIndexPath:forChangeType:newIndexPath:)]) {
		[self.fetchedResultsControllerDelegate fetchedResultsController:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:indexPath];
	}
}

- (void)controllerWillChangeContent:(NSFetchedResultsController*)controller {
	if([self.fetchedResultsControllerDelegate respondsToSelector:@selector(fetchedResultsControllerWillChangeContent:)]) {
		[self.fetchedResultsControllerDelegate fetchedResultsControllerWillChangeContent:controller];
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController*)controller {
	if([self.fetchedResultsControllerDelegate respondsToSelector:@selector(fetchedResultsControllerDidChangeContent:)]) {
		[self.fetchedResultsControllerDelegate fetchedResultsControllerDidChangeContent:controller];
	}
}


// =================================================================================================
#pragma mark - Cell Identifiers (Private)
// =================================================================================================


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
