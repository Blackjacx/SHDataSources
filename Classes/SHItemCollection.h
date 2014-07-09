//
//  SHItemCollection.h
//  SHDataSources
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHItemCollection : NSObject

- (instancetype)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier;

- (void)addItems:(NSArray*)items toSection:(NSUInteger)section withCellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 3)));
- (void)insertItems:(NSArray*)items atIndexPath:(NSIndexPath*)indexPath withCellIdentifier:(NSString*)cellIdentifier __attribute((nonnull(1, 2, 3)));
- (void)removeItems:(NSArray*)items fromSection:(NSUInteger)section __attribute((nonnull(1)));

- (NSString*)cellIdentifierForIndexPath:(NSIndexPath*)indexPath;
- (id)itemAtIndexPath:(NSIndexPath*)indexPath;

- (NSInteger)sectionCount;
- (NSInteger)rowCountForSection:(NSUInteger)section;

@end
