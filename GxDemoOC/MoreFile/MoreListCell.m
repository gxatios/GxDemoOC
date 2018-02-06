//
//  MoreListCell.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/31.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "MoreListCell.h"

@implementation MoreListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _redView.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
