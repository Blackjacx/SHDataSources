//
//  SHDataSource_Protected.h
//  SHDataSources
//
//  Created by Stefan Herold on 21/03/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHDataSource.h"

@interface SHDataSource ()
@property(nonatomic, strong)SHItemCollection *itemCollection;
@property(nonatomic, strong)SHDataSourceCellConfigurationHandler cellConfigurationHandler;
@end
