//
//  ZHXHomeIndexContrl.m
//  Gx
//
//  Created by zhangyan on 15/9/24.
//  Copyright © 2015年 Gx All rights reserved.
//

#import "ZHXHomeIndexContrl.h"

@interface ZHXHomeIndexContrl()

@property (strong, nonatomic) IBOutlet UIView *indexContrl;

@property (nonatomic , assign) NSInteger dataNum;

@end

@implementation ZHXHomeIndexContrl

- (instancetype)initWithDatas:(NSInteger )num
{
    self = [[[NSBundle mainBundle]loadNibNamed:@"ZHXHomeIndexContrl" owner:self options:nil]lastObject];
    if (self)
    {
        self.dataNum = num;
        
        [self bindingWithSubviews:num];
        
        [self moveIndex:0];
    }
    return self;
}

- (void)bindingWithSubviews:(NSInteger )num
{
    for (int i = 0; i < num; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *selectImg = [MacroMethodObject createImageWithColor:HEXCOLOR(0x3A90FF) andRect:CGRectMake(0, 0, 8, 8) andCornerRadius:4];
        UIImage *unseleImg = [MacroMethodObject createImageWithColor:[UIColor whiteColor] andRect:CGRectMake(0, 0, 8, 8) andCornerRadius:4];
        
        [button setBackgroundImage:unseleImg forState:UIControlStateNormal];
        [button setBackgroundImage:selectImg
                          forState:UIControlStateSelected];
        button.frame = CGRectMake((i) * 15, 0, 8, 8);
        button.layer.borderColor = HEXCOLOR(0x3A90FF).CGColor;
        button.layer.borderWidth = 0.5;
        button.layer.cornerRadius = 4;
        [self.indexContrl addSubview:button];
    }
    self.indexContrl.width = (num-1) *15;
  
//    self.indexContrl.left =  PhoneScreen_WIDTH- self.indexContrl.width -20;
    self.indexContrl.left = (PhoneScreen_WIDTH - self.indexContrl.width)/2;
}

- (void)moveIndex:(NSInteger)index
{
    if (index < self.dataNum)
    {
        for (UIButton *button in self.indexContrl.subviews)
        {

            button.selected = NO;
        }

        UIButton *button = self.indexContrl.subviews[index];
        button.selected = YES;

    }
    if (index < _dataNum)
    {
        for (UIButton *button in self.indexContrl.subviews)
        {
            button.selected = NO;
        }
        
        UIButton *button = self.indexContrl.subviews[index];
        button.selected = YES;
    }
}

@end
