//
//  SHDataSource.h
//  SHDataSources
//
//  Created by Stefan Herold on 20/03/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHItemCollection;

typedef void(^SHDataSourceViewConfigurationHandler)(id cell, id item, NSIndexPath *indexPath);

FOUNDATION_EXPORT NSString *const SHDataSourceInsertedItemNotification;
FOUNDATION_EXPORT NSString *const SHDataSourceDeletedItemNotification;
FOUNDATION_EXPORT NSString *const SHDataSourceMovedItemNotification;


// =================================================================================================
#pragma mark - SHDataSource Cell Data Handler
// =================================================================================================


@protocol SHDataSourcesCellDataHandler <NSObject>
- (void)setData:(id)data;
@end


// =================================================================================================
#pragma mark - SHDataSource Class Interface
// =================================================================================================


@interface SHDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

@property(nonatomic, assign, getter=isEditable)BOOL editable;
@property(nonatomic, assign, getter=isDraggingEnabled)BOOL draggingEnabled;
@property(nonatomic, strong)SHDataSourceViewConfigurationHandler supplementaryElementConfigurationHandler;

+ (instancetype)dataSourceWithItemCollection:(SHItemCollection*)itemCollection cellConfigurationHandler:(SHDataSourceViewConfigurationHandler)cellConfigurationHandler __attribute((nonnull(1, 2)));
- (instancetype)initWithItemCollection:(SHItemCollection*)itemCollection cellConfigurationHandler:(SHDataSourceViewConfigurationHandler)cellConfigurationHandler __attribute((nonnull(1, 2)));

- (id)itemAtIndexPath:(NSIndexPath*)indexPath;
- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath;

- (void)addItems:(NSArray*)items toSection:(NSUInteger)section cellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 3)));
- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 2, 3)));
- (void)removeItems:(NSArray*)items fromSection:(NSUInteger)section __attribute((nonnull(1)));

@end
