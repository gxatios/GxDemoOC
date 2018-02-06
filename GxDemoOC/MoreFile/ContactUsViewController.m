//
//  ContactUsViewController.m
//  GxDemoOC
//
//  Created by GaoX on 2017/9/23.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threelabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;
@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
@property (weak, nonatomic) IBOutlet UILabel *sixLabel;
@property (weak, nonatomic) IBOutlet UILabel *sevenLabel;

@property (nonatomic, copy) NSString *userPhoneStr;
@property (nonatomic, copy) NSString *compPhoneStr;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"联系我们";
    [self contactRequest];
}
- (IBAction)twoPhoneBD:(UIButton *)sender {
    [MacroMethodObject callPhoneMethod:_userPhoneStr];
}
- (IBAction)threePhoneBD:(UIButton *)sender {
     [MacroMethodObject callPhoneMethod:_compPhoneStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)contactRequest{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
