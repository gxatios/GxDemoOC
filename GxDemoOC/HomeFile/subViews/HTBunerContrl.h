//
//  HTBunerContrl.h
//  XFGJ
//
//  Created by 黄铁 on 14-8-25.
//  Copyright (c) 2014年 Gx All rights reserved.
//

#import <UIKit/UIKit.h>

#define VediotimerLevel 5.0 

@protocol HTBunerContrlDelegate <NSObject>

- (void)bunerContrlDidTouch:(NSInteger)index;

- (void)bunerContrlShowInIndex:(NSInteger)index;

@end

@interface HTBunerContrl : UIScrollView<UIScrollViewDelegate>

@property (nonatomic , strong) NSArray *pictures;

@property (nonatomic , assign) id<HTBunerContrlDelegate> bunerDelegate;

- (id)initWithFrame:(CGRect)frame withPictures:(NSArray *)picture autoR:(BOOL)autoR;

- (void)releaseContrl;

@end
