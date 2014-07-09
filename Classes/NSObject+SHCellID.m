//
//  NSObject+SHCellID.m
//  SHDataSources
//
//  Created by Stefan Herold on 09/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "NSObject+SHCellID.h"
#include <objc/runtime.h>


@implementation NSObject (SHCellID)

- (void)setAssociatedCellIdentifer:(NSString *)cellIdentifier {
    objc_setAssociatedObject(self, @selector(associatedCellIdentifer), cellIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)associatedCellIdentifer {
    return objc_getAssociatedObject(self, @selector(associatedCellIdentifer));
}

@end
