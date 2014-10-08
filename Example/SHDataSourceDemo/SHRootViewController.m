//
//  SHRootViewController.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHRootViewController.h"

NSString *SHRootViewControllerCellID = @"SHRootViewControllerCellID";
NSString *SHRootViewControllerSIDTableViewDataSource = @"SHRootViewControllerSIDTableViewDataSource";

@interface SHRootViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SHDataSource * dataSource;
@end

@implementation SHRootViewController


// =================================================================================================
#pragma mark - Loading
// =================================================================================================


- (void)viewDidLoad {
    [super viewDidLoad];
	
	SHItemCollection *collection = [[SHItemCollection alloc] initWithItems:@[@"Table View"] cellIdentifier:SHRootViewControllerCellID];
	self.dataSource = [SHDataSource dataSourceWithItemCollection:collection cellConfigurationHandler:^(UITableViewCell* cell, NSString * title, NSIndexPath *indexPath) {
		cell.textLabel.text = title;
		cell.textLabel.textColor = [UIColor blackColor];
	}];
	self.tableView.dataSource = self.dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// =================================================================================================
#pragma mark - Navigation
// =================================================================================================


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if([segue.identifier isEqualToString:SHRootViewControllerSIDTableViewDataSource]) {
		
	}
}


// =================================================================================================
#pragma mark - UITableView Delegate
// =================================================================================================


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
