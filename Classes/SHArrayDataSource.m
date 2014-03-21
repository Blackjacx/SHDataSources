//
//  SHArrayDataSource.m
//  Vault
//
//  Created by Stefan Herold on 20/03/14.
//
//

#import "SHArrayDataSource.h"
#import "SHArrayDataSource_Protected.h"

@implementation SHArrayDataSource

- (id)init {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier configureCellWithItemBlock:(SHArrayDataSourceConfigureCellWithItemBlock)configureCellWithItemBlock {
	self = [super init];
	if (self) {
		_items = [NSArray arrayWithArray:items];
		_cellIdentifier = cellIdentifier;
		_configureCellWithItemBlock = configureCellWithItemBlock;
	}
	return self;
}

#pragma mark -
#pragma mark Internal Helpers

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
	return self.items[indexPath.row];
}

#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self itemAtIndexPath:indexPath];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
	self.configureCellWithItemBlock(cell, item);
	return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//}
//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//}
//
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
//	
//}

#pragma mark -
#pragma mark UICollectionView DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id item = [self itemAtIndexPath:indexPath];
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
	self.configureCellWithItemBlock(cell, item);
	return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
