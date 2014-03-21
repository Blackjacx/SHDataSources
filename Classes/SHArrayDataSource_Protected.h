//
//  SHArrayDataSource_SHArrayDataSource_Protected.h
//  Vault
//
//  Created by Stefan Herold on 21/03/14.
//
//

#import "SHArrayDataSource.h"

@interface SHArrayDataSource ()
@property(nonatomic, strong)NSArray *items;
@property(nonatomic, copy)NSString *cellIdentifier;
@property(nonatomic, strong)SHArrayDataSourceConfigureCellWithItemBlock configureCellWithItemBlock;
@end
