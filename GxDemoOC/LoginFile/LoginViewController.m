//
//  LoginViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginForgetViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constr_height_codeview;
@property (weak, nonatomic) IBOutlet UIButton *vcodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTF;

@property (nonatomic , strong) NSTimer *codeTimer;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户登录";
    self.view.backgroundColor = [UIColor whiteColor];
    _loginBtn.layer.cornerRadius = 5;
    _constr_height_codeview.constant = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldChageAction:) name:UITextFieldTextDidChangeNotification object:nil];
    NSString *phoneLast = [[NSUserDefaults standardUserDefaults] valueForKey:User_Login_LastInput];
    if (phoneLast.length>0) {
        _phoneTF.text = phoneLast;
    }

}
- (void)textfieldChageAction:(NSNotification *)notification
{
    if (notification.object == self.phoneTF)
    {
        if (self.phoneTF.text.length > 11)
        {
            NSString *str = [self.phoneTF.text substringToIndex:11];
            self.phoneTF.text = str;
        }
    }
    if (notification.object == self.vcodeTF)
    {
        if (self.vcodeTF.text.length > 6)
        {
            NSString *str = [self.vcodeTF.text substringToIndex:6];
            self.vcodeTF.text = str;
        }
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self starTimer];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:Login_User_IsLogin];
    if (isLogin ) {
        [_loginBtn setTitle:@"退出" forState:UIControlStateNormal];
    }else{
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    
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
- (IBAction)loginBtnDown:(id)sender {
    [self loginRequest];
}
- (IBAction)regiBtnDown:(id)sender {
    UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    RegisterViewController *vc = [sB instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)forgetBtnDown:(id)sender {
    UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginForgetViewController *vc = [sB instantiateViewControllerWithIdentifier:@"LoginForgetViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)navBackBtnDown
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)loginRequest
{
    NSString *phoneStr = _phoneTF.text;
    NSString *pwStr = _pwTF.text;
    if (![MacroMethodObject validatePhoneNum:phoneStr]) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    NSString *vcodeStr = _vcodeTF.text;

    NSString *desPWStr = [MacroMethodObject encrypt3DES:pwStr key:Key_DES_PW];
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:Opt_Login forKey:@"opt"];
    [dicOne setValue:phoneStr forKey:@"name"];
    [dicOne setValue:desPWStr forKey:@"pwd"];
    [dicOne setValue:vcodeStr forKey:@"randomCode"];
    
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            [_loginBtn setTitle:@"退出" forState:UIControlStateNormal];
            // success
            NSString *mobile = [NSString stringWithFormat:@"%@",result[@"mobile"]];
            NSString *idStr = [NSString stringWithFormat:@"%@",result[@"id"]];
            NSString *username = [NSString stringWithFormat:@"%@",result[@"userName"]];
            NSString *headImg = [NSString stringWithFormat:@"%@",result[@"headImg"]];
//            NSString *sex = [NSString stringWithFormat:@"%@",result[@"sex"]];
            NSString *realName = [NSString stringWithFormat:@"%@",result[@"realName"]];
            NSString *role = [NSString stringWithFormat:@"%@",result[@"role"]];
            NSString *countMsgUnread = [NSString stringWithFormat:@"%@",result[@"countMsgUnread"]];
            NSString *isSign = [NSString stringWithFormat:@"%@",result[@"isSign"]];
            NSString *qrCode = [NSString stringWithFormat:@"%@",result[@"qrCode"]];
            NSString *score = [NSString stringWithFormat:@"%@",result[@"score"]];
            NSString *empRole = [NSString stringWithFormat:@"%@",result[@"empRole"]];
            
            [[NSUserDefaults standardUserDefaults] setValue:isSign forKey:Login_User_IsSign];
            [[NSUserDefaults standardUserDefaults] setValue:qrCode forKey:Login_User_QrCode];
            [[NSUserDefaults standardUserDefaults] setValue:score forKey:Login_User_Score];
            [[NSUserDefaults standardUserDefaults] setValue:countMsgUnread forKey:Login_User_CountMsgUnread];
            [[NSUserDefaults standardUserDefaults] setValue:role forKey:Login_User_Role]; // 0客户 1 员工
//            [[NSUserDefaults standardUserDefaults] setValue:sex forKey:Login_User_Sex];
            [[NSUserDefaults standardUserDefaults] setValue:headImg forKey:Login_User_HeadImg];
            [[NSUserDefaults standardUserDefaults] setValue:idStr forKey:Login_User_Id];
            [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:Login_User_Phone];
            [[NSUserDefaults standardUserDefaults] setValue:realName forKey:Login_User_RealName];
            [[NSUserDefaults standardUserDefaults] setValue:username forKey:Login_User_NickName];
            [[NSUserDefaults standardUserDefaults] setValue:empRole forKey:Login_User_Role_Emp];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Login_User_IsLogin];
            [[NSUserDefaults standardUserDefaults] setValue:mobile forKey:User_Login_LastInput];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
            if (self.loginBlock) {
                self.loginBlock();
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
          //  [self.navigationController popViewControllerAnimated:YES];
        }else if ([error isEqualToString:@"-99"]) {
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
            _constr_height_codeview.constant = 60;
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
        
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}

- (IBAction)vcodeBtnDown:(id)sender {
    NSString *phoneStr = _phoneTF.text;
    if (![MacroMethodObject validatePhoneNum:phoneStr]) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:Opt_Vcode forKey:@"opt"];
    [dicOne setValue:phoneStr forKey:@"mobile"];
    [dicOne setValue:@"2" forKey:@"validateType"];
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
            [self.vcodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [self.vcodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.vcodeBtn.userInteractionEnabled = YES;
        }
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
