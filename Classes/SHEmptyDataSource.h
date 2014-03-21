//
//  SHEmptyDataSource.h
//  Vault
//
//  Created by Stefan Herold on 20/03/14.
//
//

#import <UIKit/UIKit.h>

@interface SHEmptyDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

+ (instancetype)sharedInstance;

@end
