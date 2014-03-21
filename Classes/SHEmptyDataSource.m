//
//  SHEmptyDataSource.m
//  Vault
//
//  Created by Stefan Herold on 20/03/14.
//
//

#import "SHEmptyDataSource.h"

@implementation SHEmptyDataSource

+ (instancetype)sharedInstance {
	static SHEmptyDataSource *instance = nil;
	static dispatch_once_t pred;
	
	dispatch_once(&pred, ^{
		instance = [[SHEmptyDataSource alloc] init];
	});
	return instance;
}

#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// We can safely return nil here because no cells will be requested since the numberOfRows and numberOfSections methods return zero.
	return nil;
}

#pragma mark -
#pragma mark UICollectionView DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 0;
}

@end
