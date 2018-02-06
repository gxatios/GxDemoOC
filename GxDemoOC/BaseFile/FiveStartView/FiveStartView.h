//
//  FiveStartView.h
//  GxDemoOC
//
//  Created by GaoX on 2017/10/22.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FiveStartViewBlock)(NSInteger startNum);

@interface FiveStartView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;
@property (weak, nonatomic) IBOutlet UIImageView *oneImg;
@property (weak, nonatomic) IBOutlet UIImageView *twoImgV;

@property (weak, nonatomic) IBOutlet UIImageView *threeImgV;
@property (weak, nonatomic) IBOutlet UIImageView *fourImgV;
@property (weak, nonatomic) IBOutlet UIImageView *fiveImgV;

@property (nonatomic, copy) FiveStartViewBlock numBlock;

-(void)setStartNum:(NSString *)num;
- (instancetype)initWithFrame:(CGRect)frame;

@end
