//
//  SHMutableArrayDataSource.m
//  Vault
//
//  Created by Stefan Herold on 21/03/14.
//
//

#import "SHMutableArrayDataSource.h"
#import "SHArrayDataSource_Protected.h"

NSString *const SHMutableArrayDataSourceInsertedItemNotification = @"SHMutableArrayDataSourceInsertedItemNotification";
NSString *const SHMutableArrayDataSourceDeletedItemNotification = @"SHMutableArrayDataSourceDeletedItemNotification";
NSString *const SHMutableArrayDataSourceMovedItemNotification = @"SHMutableArrayDataSourceMovedItemNotification";

@implementation SHMutableArrayDataSource

#pragma mark -
#pragma mark UITableView DataSource

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSMutableArray *mutableItems = [self.items mutableCopy];
	switch (editingStyle) {
		case UITableViewCellEditingStyleDelete: {
			[mutableItems removeObjectAtIndex:indexPath.row];
			[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[self postDeletedItemNotification];
		}
			break;
		
		case UITableViewCellEditingStyleNone: {
		}
			break;
			
		case UITableViewCellEditingStyleInsert: {
			[self postDeletedItemNotification];
		}
			break;
	}
	self.items = [mutableItems copy];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	[tableView beginUpdates];
	NSMutableArray *mutableItems = [self.items mutableCopy];
	id movedObj = self.items[sourceIndexPath.row];
	[mutableItems removeObjectIdenticalTo:movedObj];
	[mutableItems insertObject:movedObj atIndex:destinationIndexPath.row];
	self.items = [mutableItems copy];
	[tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
	[tableView endUpdates];
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
	[[NSNotificationCenter defaultCenter] postNotificationName:SHMutableArrayDataSourceInsertedItemNotification object:self];
}

- (void)postDeletedItemNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:SHMutableArrayDataSourceDeletedItemNotification object:self];
}

- (void)postMovedItemNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:SHMutableArrayDataSourceMovedItemNotification object:self];
}

#pragma mark -
#pragma mark DataSourceModifiers

- (void)addObject:(id)object {
	NSMutableArray *mutableItems = [self.items mutableCopy];
	[mutableItems addObject:object];
	self.items = [mutableItems copy];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
	NSMutableArray *mutableItems = [self.items mutableCopy];
	[mutableItems insertObject:object atIndex:index];
	self.items = [mutableItems copy];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
	NSMutableArray *mutableItems = [self.items mutableCopy];
	[mutableItems removeObjectAtIndex:index];
	self.items = [mutableItems copy];
}

@end
