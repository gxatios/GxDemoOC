//
//  UpImgView.h
//  GxDemoOC
//
//  Created by GaoX on 2017/10/14.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpImgViewBlock)(NSInteger index);

@interface UpImgView : UIView
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *showImgV;

@property (nonatomic, assign) NSInteger indexNum;
@property (nonatomic, copy) UpImgViewBlock upBlock;
@end
