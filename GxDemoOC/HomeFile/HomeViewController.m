//
//  HomeViewController.m
//  GxDemoOC
//
//  Created by zhxGx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "HomeViewController.h"
#import "HTBunerContrl.h"
#import "ZHXHomeIndexContrl.h"


@interface HomeViewController () <HTBunerContrlDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *homeScrollV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constr_h_upv;

// banner
@property (weak, nonatomic) IBOutlet UIView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIView *pageControlView;
@property (nonatomic, strong) HTBunerContrl *bunerContrl;
@property (nonatomic, strong) ZHXHomeIndexContrl *homeIndexContrl;
@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *goodsArray;



@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.navigationController.navigationBar.translucent = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    [self getSiftFirstrequest];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGBCOLOR(229, 229, 229, 1);
    self.bannerArray = [[NSMutableArray alloc] init];
    self.goodsArray = [[NSMutableArray alloc] init];
    //    NSArray *imgArray = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner3", nil];
    //    [self bindingWithBunercontrl:imgArray];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- banner themes --
- (void)bindingWithBunercontrl:(NSArray *)datas{
    CGRect bannerRect = CGRectMake(0, 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height);
    [self.bunerContrl releaseContrl];
    self.bunerContrl = [[HTBunerContrl alloc] initWithFrame:bannerRect withPictures:datas autoR:YES];
    self.bunerContrl.backgroundColor = [UIColor clearColor];
    self.bunerContrl.bunerDelegate = self;
    [self.bannerScrollView addSubview:self.bunerContrl];
    self.bannerScrollView.backgroundColor = [UIColor clearColor];
    [self bindingWithIndexContrl:datas];
}

- (void)bunerContrlShowInIndex:(NSInteger)index{
    [self.homeIndexContrl moveIndex:index];
}

- (void)bindingWithIndexContrl:(NSArray *)datas{
    [self.homeIndexContrl removeFromSuperview];
    self.homeIndexContrl = [[ZHXHomeIndexContrl alloc] initWithDatas:datas.count];
    CGRect rect = CGRectMake(0, 0, _homeIndexContrl.frame.size.width, _homeIndexContrl.frame.size.height);
    _homeIndexContrl.frame = rect;
    [self.pageControlView addSubview:self.homeIndexContrl];
    
}

- (void)bunerContrlDidTouch:(NSInteger)index{ //banner 点击
    NSDictionary *model = self.bannerArray[index];//    url = "app://browser?pid=3";
    NSString *urlStr = [NSString stringWithFormat:@"%@",model[@"url"]];
    NSString *titleStr = [NSString stringWithFormat:@"%@",model[@"title"]];
    NSString *is_link_enabled = [NSString stringWithFormat:@"%@",model[@"is_link_enabled"]];
    if ([is_link_enabled isEqualToString:@"1"]) {
        if ([titleStr isEqualToString:@"(null)"]) {
            titleStr = @"";
        }
        if (urlStr.length > 0 && ![urlStr isEqualToString:@"(null)"]) {
            if ([urlStr containsString:@"http://"]) {
               
                
            }else{
                
            }
        }
    }
}
#pragma mark --
-(NSString *)countNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }  
    [newstring insertString:string atIndex:0];
    return newstring;
}
#pragma mark -- request --
-(void)getSiftFirstrequest{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:@"1" forKey:@"opt"];
    //    [dicOne setValue:@"post" forKey:@"type"];
    [dicOne setValue:@"1" forKey:@"userId"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
           
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}
- (void)refreshGoodsData{
   
}

-(void)goodsDetailJump:(NSInteger)index{
    if (self.goodsArray.count<index+1) {
        return;
    }
    // success


}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)baseDataRequest{
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:Opt_Up_NormalDataInfo forKey:@"opt"];
    [dicOne setValue:@"constants" forKey:@"typeStr"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
            [UpDataInfoObject sharedInstanceTool].mainData = result;

        }else{
        }
    } requestFailure:^{
    }];
}
- (void)dealloc
{
    
    [self.bunerContrl releaseContrl];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _constr_h_upv.constant = 0;
    if (scrollView.contentOffset.y<=-40) {
        [self getSiftFirstrequest];
    }
}
@end
