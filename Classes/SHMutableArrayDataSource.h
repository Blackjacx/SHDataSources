//
//  SHMutableArrayDataSource.h
//  Vault
//
//  Created by Stefan Herold on 21/03/14.
//
//

#import <UIKit/UIKit.h>
#import "SHArrayDataSource.h"

extern NSString *const SHMutableArrayDataSourceInsertedItemNotification;
extern NSString *const SHMutableArrayDataSourceDeletedItemNotification;
extern NSString *const SHMutableArrayDataSourceMovedItemNotification;

@interface SHMutableArrayDataSource : SHArrayDataSource <UITableViewDataSource, UICollectionViewDataSource>

- (void)addObject:(id)object;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;

@end
