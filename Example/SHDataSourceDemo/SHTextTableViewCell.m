//
//  SHSHTextTableViewCell.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 09/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHTextTableViewCell.h"

@implementation SHTextTableViewCell

- (void)setData:(id)data {
	if (![data isKindOfClass:[NSString class]]) return;
	self.textLabel.text = data;
	self.textLabel.font = [UIFont systemFontOfSize:12.0f];
	self.textLabel.textColor = [UIColor grayColor];
	self.textLabel.backgroundColor = [UIColor clearColor];
}

@end
