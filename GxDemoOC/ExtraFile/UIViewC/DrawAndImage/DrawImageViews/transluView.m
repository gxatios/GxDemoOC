//
//  transluView.m
//  GXOnlineDemo
//
//  Created by gaoxin on 14-4-5.
//  Copyright (c) 2014年 xin gao. All rights reserved.
//

#import "transluView.h"

@implementation transluView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor orangeColor];
//        [self drawRect:frame];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect currentBounds = self.bounds;
    
    CGGradientRef backgroundGradient;
    
    size_t num_locations = 2;
    
    CGFloat locations[2] = { 0.0, 1.0 }; // Start color
    
    CGFloat components[8] = { 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 0.0, 0.6}; // End color
    
    CGColorSpaceRef rgbColorspace = CGColorSpaceCreateDeviceRGB();
    
    backgroundGradient = CGGradientCreateWithColorComponents (rgbColorspace, components, locations, num_locations);
    
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMidY(currentBounds));
    
    CGContextDrawRadialGradient (context, backgroundGradient, centerPoint, 0.0, centerPoint, currentBounds.size.width, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(backgroundGradient);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
