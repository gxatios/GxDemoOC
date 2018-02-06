//
//  HTBunerContrl.m
//  XFGJ
//
//  Created by 黄铁 on 14-8-25.
//  Copyright (c) 2014年 Gx All rights reserved.
//

#import "HTBunerContrl.h"

@interface HTBunerContrl()

@property (nonatomic , assign) NSInteger pegeIndex;

@property (nonatomic , strong) NSTimer *timer;

@end

@implementation HTBunerContrl

- (id)initWithFrame:(CGRect)frame withPictures:(NSArray *)picture autoR:(BOOL)autoR
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _pictures = picture;
        [self createWithSubviews:autoR];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)createWithSubviews:(BOOL)autoR
{
    self.pagingEnabled = YES;
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    //如果这有一张图片
    if (self.pictures.count == 1)
    {
        UIImageView *onePicture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSString *picStr = [NSString stringWithFormat:@"%@%@",Net_Image_Host,self.pictures[0][@"image_filename"]];
        [onePicture sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner1.jpg"] options:SDWebImageContinueInBackground|SDWebImageProgressiveDownload|SDWebImageRefreshCached];
        onePicture.contentMode = UIViewContentModeScaleToFill;

        onePicture.clipsToBounds = YES;
        [self addSubview:onePicture];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPicture:)];
        onePicture.userInteractionEnabled = YES;
        [onePicture addGestureRecognizer:tap];
    }
    else
    {
        NSInteger count = 0;
        
        if(self.pictures.count == 2)
        {
            count = 4;
        }
        else
        {
            count = self.pictures.count;
        }
        
        for(int i = 0; i < count; i++)
        {
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.clipsToBounds = YES;
            imgView.frame = CGRectMake(self.width * i, 0, self.width, self.height);
            NSDictionary *currDic  = self.pictures[self.pictures.count == 2 ? i % 2 : i];
            NSString *picStr = [NSString stringWithFormat:@"%@%@",Net_Image_Host,currDic[@"image_filename"]];
            [imgView sd_setImageWithURL:[NSURL URLWithString:picStr] placeholderImage:[UIImage imageNamed:@"banner1"] options:SDWebImageContinueInBackground|SDWebImageProgressiveDownload|SDWebImageRefreshCached];
            [self addSubview:imgView];
            imgView.contentMode = UIViewContentModeScaleToFill;

            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchPicture:)];
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:tap];
        }
        
        //列表宽度
        self.contentSize = CGSizeMake(self.width * count , self.height);
        
        //设置ScrollView显示的位置为中间的位置
        [self displayCenter];
        
        //重置坐标
        [self sortImageViewWithFrame];
        
        //是否自动滑动
        if(autoR)
        {
            [self bindingWithTimer];
        }
    }
}

#pragma mark 方法
- (void)displayCenter
{
    [self setContentOffset:CGPointMake(self.width * ((self.pictures.count == 2 ? 4 : self.pictures.count) / 2), 0) animated:NO];
}

- (void)setPegeIndex:(NSInteger)pegeIndex
{
    if (pegeIndex < 0)
    {
        _pegeIndex = self.pictures.count - 1;
    }
    else if (pegeIndex > self.pictures.count - 1)
    {
        _pegeIndex = 0;
    }
    else	
    {
        _pegeIndex = pegeIndex;
    }
    
    [self.bunerDelegate bunerContrlShowInIndex:_pegeIndex];
}

//给图片的位置从新排序, 例：12345 排序后变成 45123
- (void)sortImageViewWithFrame
{
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - count / 2 ; i > 0 ; i --)
    {
        for (NSInteger j = count - 1; j > 0; j --)
        {
            CGRect tmpRect;
            UIImageView *viewA = self.subviews[j];
            UIImageView *viewB = self.subviews[j - 1];
            tmpRect = viewA.frame;
            viewA.frame = viewB.frame;
            viewB.frame = tmpRect;
            viewA.contentMode = UIViewContentModeScaleToFill;
            viewB.contentMode = UIViewContentModeScaleToFill;
        }
    }
}

- (void)sortFrameWhenDecelerating
{
    if (self.contentOffset.x - self.contentSize.width / 2 < -self.width / 2)
    {
        [self leftRolling];
    }
    else if (self.contentOffset.x - self.contentSize.width / 2 >= self.width / 2)
    {
        [self rightRolling];
    }
}

- (void)leftRolling
{
    self.pegeIndex -= 1;
    for (int i = 0 ; i < self.subviews.count - 1; i ++)
    {
        CGRect tmpRect;
        UIImageView *viewA = self.subviews[i];
        UIImageView *viewB = self.subviews[i + 1];
        tmpRect = viewA.frame;
        viewA.frame = viewB.frame;
        viewB.frame = tmpRect;
        viewA.contentMode = UIViewContentModeScaleToFill;
        viewB.contentMode = UIViewContentModeScaleToFill;
    }
    [self displayCenter];
}

- (void)rightRolling
{
    self.pegeIndex += 1;
    for (NSInteger i = self.subviews.count - 1 ; i > 0 ; i --)
    {
        CGRect tmpRect;
        UIImageView *viewA = self.subviews[i];
        UIImageView *viewB = self.subviews[i - 1];
        tmpRect = viewA.frame;
        viewA.frame = viewB.frame;
        viewB.frame = tmpRect;
        viewA.contentMode = UIViewContentModeScaleToFill;
        viewB.contentMode = UIViewContentModeScaleToFill;
    }
    [self displayCenter];
}

- (void)autoRolling
{
    [self setContentOffset:CGPointMake(self.contentOffset.x + self.width, 0) animated:YES];
    [self performSelector:@selector(rightRolling) withObject:nil afterDelay:.8];
}

//释放自己
- (void)releaseContrl
{
    //关闭定时器
    [self closeWithTimer];
    
    //代理制空
    self.bunerDelegate = nil;
    
    //移除视图
    [self removeFromSuperview];
}

//开启定时器
- (void)bindingWithTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:VediotimerLevel target:self selector:@selector(autoRolling) userInfo:nil repeats:YES];
}

//关闭定时器
- (void)closeWithTimer
{
    [self.timer invalidate];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self sortFrameWhenDecelerating];
    [self bindingWithTimer];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    [self closeWithTimer];
}

#pragma mark 点击事件
- (void)touchPicture:(UITapGestureRecognizer *)tap
{
    NSInteger index = [self.subviews indexOfObject:tap.view];
    if (self.pictures.count == 2)
    {
        index = index % 2;
    }
    [self.bunerDelegate bunerContrlDidTouch:index];
}




@end
