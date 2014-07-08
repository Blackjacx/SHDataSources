//
//  SHDataSource_Protected.h
//  SHDataSources
//
//  Created by Stefan Herold on 21/03/14.
//
//

#import "SHDataSource.h"

@interface SHDataSource ()
@property(nonatomic, strong)SHItemCollection *itemCollection;
@property(nonatomic, strong)SHDataSourceCellConfigurationHandler cellConfigurationHandler;
@end
