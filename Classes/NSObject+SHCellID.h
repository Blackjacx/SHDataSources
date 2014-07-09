//
//  NSObject+SHCellID.h
//  SHDataSources
//
//  Created by Stefan Herold on 09/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SHCellID)

/**
 *  The cell identifier associated to the object
 */
@property (nonatomic, strong) NSString *associatedCellIdentifer;

@end
