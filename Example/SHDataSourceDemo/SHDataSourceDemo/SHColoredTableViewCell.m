//
//  SHTableViewCell.m
//  SHDataSourceDemo
//
//  Created by Stefan Herold on 08/07/14.
//  Copyright (c) 2014 Stefan Herold. All rights reserved.
//

#import "SHColoredTableViewCell.h"

@implementation SHColoredTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(id)data {
	if (![data isKindOfClass:[UIColor class]]) return;
	self.contentView.backgroundColor = data;
	self.textLabel.text = [data debugDescription];
	self.textLabel.font = [UIFont systemFontOfSize:12.0f];
	self.textLabel.textColor = [UIColor grayColor];
}

@end
