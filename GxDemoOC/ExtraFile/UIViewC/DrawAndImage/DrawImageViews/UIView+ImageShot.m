//
//  UIView+ImageShot.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-4-9.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "UIView+ImageShot.h"

@implementation UIView (ImageShot)

-(UIImage*)convertViewToImage{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
