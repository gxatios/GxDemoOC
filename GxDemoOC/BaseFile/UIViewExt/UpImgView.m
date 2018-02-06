//
//  UpImgView.m
//  GxDemoOC
//
//  Created by GaoX on 2017/10/14.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "UpImgView.h"

@implementation UpImgView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setExclusiveTouch:YES];
    [[NSBundle mainBundle] loadNibNamed:@"LeftItemView" owner:self options:nil];
    [self addSubview:self.contentView];
}

- (void)layoutSubviews {
    //调整子viewframe
    self.contentView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self awakeFromNib];
    }
    return self;
}
-(void)buildViews:(CGRect)frame
{

}
- (IBAction)upBtnDown:(UIButton *)sender {
    if (self.upBlock) {
        self.upBlock(self.indexNum);
    }
}

@end
