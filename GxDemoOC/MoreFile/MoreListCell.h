//
//  MoreListCell.h
//  GxDemoOC
//
//  Created by Gx on 2017/8/31.
//  Copyright © 2017年 gx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UILabel *txtLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIView *redView;
@end
