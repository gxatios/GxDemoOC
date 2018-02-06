//
//  LoginForgetViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "LoginForgetViewController.h"

@interface LoginForgetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTF;
@property (weak, nonatomic) IBOutlet UIButton *vcodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
@property (weak, nonatomic) IBOutlet UITextField *rePwTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic , strong) NSTimer *codeTimer;

@end

@implementation LoginForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    _submitBtn.layer.cornerRadius = 5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldChageAction:) name:UITextFieldTextDidChangeNotification object:nil];

}
- (void)textfieldChageAction:(NSNotification *)notification
{
    if (notification.object == self.phoneTF){
        if (self.phoneTF.text.length > 11){
            NSString *str = [self.phoneTF.text substringToIndex:11];
            self.phoneTF.text = str;
        }
    }
    if (notification.object == self.vcodeTF){
        if (self.vcodeTF.text.length > 6){
            NSString *str = [self.vcodeTF.text substringToIndex:6];
            self.vcodeTF.text = str;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self starTimer];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)vcodeBtnDown:(id)sender {
    NSString *phoneStr = _phoneTF.text;
    if (![MacroMethodObject validatePhoneNum:phoneStr]) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];

    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            [self saveCodeTime];
            [self starTimer];
            // success
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
            
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}
- (IBAction)submitBtnDown:(id)sender {
    [_phoneTF resignFirstResponder];
    [_pwTF resignFirstResponder];
    [_vcodeTF resignFirstResponder];
    NSString *phoneStr = _phoneTF.text;
    if(![MacroMethodObject validatePhoneNum:phoneStr]){
         [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    [self registerRequest];
}

-(void)registerRequest
{
    NSString *phoneStr = _phoneTF.text;
    NSString *vcodeStr = _vcodeTF.text;
    NSString *pwStr = _pwTF.text;
    NSString *rePwStr = _rePwTF.text;
    if (pwStr.length > 0) {
    }else{
        [MacroMethodObject showHudTextinWindow:@"请输入新密码"];
    }
    if (![pwStr isEqualToString:rePwStr]) {
        [MacroMethodObject showHudTextinWindow:@"两次密码输入不一致"];
        return;
    }if (vcodeStr.length != 6) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];

    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            [MacroMethodObject showHudTextinWindow:@"密码重置成功"];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Do something...
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}
- (void)starTimer
{
    //初始化定时器
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [self.codeTimer invalidate];
}
#pragma mark 验证码发送时间保存
- (void)saveCodeTime
{
    [MacroDataObject saveDataList:[NSDate date] fileName:CodeDateTimeSave];
}

- (NSDate *)loadCodeTime
{
    return [MacroDataObject loadDataList:CodeDateTimeSave];
}

- (NSInteger)now:(NSDate *)now before:(NSDate *)before
{
    NSTimeInterval late = [before timeIntervalSince1970] * 1;
    NSTimeInterval nowInt = [now timeIntervalSince1970] * 1;
    
    NSTimeInterval cha = nowInt - late;
    return cha;
}

#pragma mark 触发事件
//定时器
- (void)timerFired:(NSTimer *)timer
{
    if([self loadCodeTime])
    {
        NSInteger cha = [self now:[NSDate date] before:[self loadCodeTime]];
        if (cha < CodeTimeCount)
        {
            //限制重发
            self.vcodeBtn.userInteractionEnabled = NO;
            //            [self.sendCode setBackgroundImage:[UIImage imageNamed:@"login_4@2x"] forState:UIControlStateNormal];
            
            [self.vcodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            [self.vcodeBtn setTitle:[NSString stringWithFormat:@"%d秒后重发", (int)CodeTimeCount - (int)cha] forState:UIControlStateNormal];
        }
        else
        {
            //可以重发
            //            [self.sendCode setBackgroundImage:[UIImage imageNamed:@"login_11@2x"] forState:UIControlStateNormal];
            [self.vcodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.vcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.vcodeBtn.userInteractionEnabled = YES;
        }
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
