//
//  FiveStartView.m
//  GxDemoOC
//
//  Created by GaoX on 2017/10/22.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "FiveStartView.h"
#define fullImage [UIImage imageNamed:@"foregroundStar.png"]
#define emptyImage [UIImage imageNamed:@"backgroundStar.png"]

@implementation FiveStartView
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setExclusiveTouch:YES];
    [[NSBundle mainBundle] loadNibNamed:@"FiveStartView" owner:self options:nil];
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

-(id)initWithFrame:(CGRect)frame numberOfStar:(int)number {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
}
-(void)setStartNum:(NSString *)numStr{
    NSString *ssStr =  [NSString stringWithFormat:@"%@",numStr];
    NSInteger xxNum = [ssStr integerValue];
    if (xxNum <=1) {
        xxNum = 1;
    }
    if (xxNum >5) {
        xxNum = 5;
    }
    [self setImgNum:xxNum];
}
- (IBAction)oneBD:(UIButton *)sender {
    [self setImgNum:1];
    [self giveNum:1];
}
- (IBAction)twoBD:(UIButton *)sender {
    [self setImgNum:2];
    [self giveNum:2];
}
- (IBAction)threeBD:(UIButton *)sender {
    [self setImgNum:3];
    [self giveNum:3];
}
- (IBAction)fourBD:(UIButton *)sender {
    [self setImgNum:4];
    [self giveNum:4];
}
- (IBAction)fiveBD:(UIButton *)sender {
    [self setImgNum:5];
    [self giveNum:5];
}
-(void)setImgNum:(NSInteger)num{
    if (num==1) {
        _oneImg.image = fullImage;
        _twoImgV.image = emptyImage;
        _threeImgV.image = emptyImage;
        _fourImgV.image = emptyImage;
        _fiveImgV.image = emptyImage;
    }else if (num == 2){
        _oneImg.image = fullImage;
        _twoImgV.image = fullImage;
        _threeImgV.image = emptyImage;
        _fourImgV.image = emptyImage;
        _fiveImgV.image = emptyImage;
    }else if (num == 3){
        _oneImg.image = fullImage;
        _twoImgV.image = fullImage;
        _threeImgV.image = fullImage;
        _fourImgV.image = emptyImage;
        _fiveImgV.image = emptyImage;
    }else if (num == 4){
        _oneImg.image = fullImage;
        _twoImgV.image = fullImage;
        _threeImgV.image = fullImage;
        _fourImgV.image = fullImage;
        _fiveImgV.image = emptyImage;
    }else{
        _oneImg.image = fullImage;
        _twoImgV.image = fullImage;
        _threeImgV.image = fullImage;
        _fourImgV.image = fullImage;
        _fiveImgV.image = fullImage;
    }
}
-(void)giveNum:(NSInteger)backNum{
    if (self.numBlock) {
        self.numBlock(backNum);
    }
}
@end
