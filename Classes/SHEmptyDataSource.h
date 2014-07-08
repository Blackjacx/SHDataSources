//
//  SHEmptyDataSource.h
//  SHDataSources
//
//  Created by Stefan Herold on 20/03/14.
//
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const SHDataSourceDefaultCellIdentifier;

@interface SHEmptyDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>
@end
