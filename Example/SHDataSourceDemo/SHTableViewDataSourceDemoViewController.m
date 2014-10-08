//
//  SHViewController.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHTableViewDataSourceDemoViewController.h"

@interface SHTableViewDataSourceDemoViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) SHDataSource * dataSource;
@end

NSString *coloredCellID = @"coloredCellID";
NSString *textCellID = @"textCellID";

@implementation SHTableViewDataSourceDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	SHItemCollection *collection = [[SHItemCollection alloc] initWithItems:@[@"Text Cell 1", @"Text Cell 2", @"Text Cell 3"] cellIdentifier:textCellID];
	self.dataSource = [SHDataSource dataSourceWithItemCollection:collection cellConfigurationHandler:^(id <SHDataSourcesCellDataHandler> cell, id item, NSIndexPath *indexPath) {
		[cell setData:item];
	}];
	self.dataSource.editable = YES;
	self.dataSource.draggingEnabled = YES;
	
	self.tableView.dataSource = self.dataSource;
	
	[self performSelector:@selector(addItemsToUltraHighSection) withObject:nil afterDelay:3.0f];
	[self performSelector:@selector(addItemsToFirstSection) withObject:nil afterDelay:6.0f];
	[self performSelector:@selector(insertItemsAtTheBeginningOfSectionOne) withObject:nil afterDelay:9.0f];
}

- (void)addItemsToUltraHighSection {
	[self.dataSource addItems:@[[UIColor purpleColor], [UIColor orangeColor]] toSection:1000 cellIdentifier:coloredCellID];
	[self.tableView reloadData];
}

- (void)addItemsToFirstSection {
	[self.dataSource addItems:@[[UIColor blackColor], [UIColor lightGrayColor]] toSection:0 cellIdentifier:coloredCellID];
	[self.tableView reloadData];
}

- (void)insertItemsAtTheBeginningOfSectionOne {
	[self.dataSource insertItems:@[[UIColor magentaColor], [UIColor yellowColor]] atIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withCellIdentifier:coloredCellID];
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark Actions


- (IBAction)onEdit:(id)sender {
	BOOL newValue = !self.tableView.editing;
	[self.tableView setEditing:newValue animated:YES];
	UIBarButtonItem *newItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:newValue ?UIBarButtonSystemItemDone : UIBarButtonSystemItemEdit target:self action:_cmd];
	self.navigationItem.rightBarButtonItem = newItem;
}


#pragma mark -
#pragma mark UITableViewCell Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellID = [self.dataSource cellIdentifierForIndexPath:indexPath];
	if([cellID isEqualToString:textCellID]) {
		return 88.0f;
	}
	return 44.0f;
}


@end
