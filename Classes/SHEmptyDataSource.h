//
//  SHEmptyDataSource.h
//  SHDataSources
//
//  Created by Stefan Herold on 20/03/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const SHDataSourceDefaultCellIdentifier;

@interface SHEmptyDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>
@end
