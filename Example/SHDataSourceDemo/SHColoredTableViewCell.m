//
//  SHTableViewCell.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHColoredTableViewCell.h"

@implementation SHColoredTableViewCell

- (void)setData:(id)data {
	if (![data isKindOfClass:[UIColor class]]) return;
	self.contentView.backgroundColor = data;
	self.textLabel.text = [data debugDescription];
	self.textLabel.font = [UIFont systemFontOfSize:12.0f];
	self.textLabel.textColor = [UIColor grayColor];
	self.textLabel.backgroundColor = [UIColor clearColor];
}

@end
