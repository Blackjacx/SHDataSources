//
//  SHArrayDataSource.h
//  Vault
//
//  Created by Stefan Herold on 20/03/14.
//
//

#import <UIKit/UIKit.h>

typedef void(^SHArrayDataSourceConfigureCellWithItemBlock)(id cell, id item);

@interface SHArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>
@property(nonatomic, strong, readonly)NSArray *items;

- (id)initWithItems:(NSArray*)items cellIdentifier:(NSString*)cellIdentifier configureCellWithItemBlock:(SHArrayDataSourceConfigureCellWithItemBlock)configureCellBlock;

@end
