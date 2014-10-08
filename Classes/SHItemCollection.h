//
//  SHItemCollection.h
//  SHDataSources
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


// =================================================================================================
#pragma mark - Delegate Protocol for the Fetched Results Controller
// =================================================================================================


@protocol SHItemCollectionFetchedResultsControllerDelegate <NSObject>

- (void)fetchedResultsController:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath;
- (void)fetchedResultsControllerWillChangeContent:(NSFetchedResultsController*)controller;
- (void)fetchedResultsControllerDidChangeContent:(NSFetchedResultsController*)controller;

@end


// =================================================================================================
#pragma mark - SHItemCollection Public Interface
// =================================================================================================


@interface SHItemCollection : NSObject <NSFetchedResultsControllerDelegate>

@property(nonatomic, weak)id<SHItemCollectionFetchedResultsControllerDelegate>fetchedResultsControllerDelegate;

- (instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier;
- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController*)fetchedResultsController cellIdentifier:(NSString*)cellIdentifier;

- (void)addItems:(NSArray*)items toSection:(NSUInteger)section withCellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 3)));
- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 2, 3)));
- (void)removeItems:(NSArray*)items fromSection:(NSUInteger)section __attribute((nonnull(1)));

- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath;
- (id)itemAtIndexPath:(NSIndexPath*)indexPath;

- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSUInteger)section;

@end
