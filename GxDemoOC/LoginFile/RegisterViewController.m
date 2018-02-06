//
//  RegisterViewController.m
//  GxDemoOC
//
//  Created by Gx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "RegisterViewController.h"
#import "AgreeInfoViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTF;
@property (weak, nonatomic) IBOutlet UITextField *vcodeTF;
@property (weak, nonatomic) IBOutlet UIButton *vcodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *inviteTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic , strong) NSTimer *codeTimer;
@property (nonatomic , assign) NSInteger agreeNum;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.agreeNum = 0;
    _subBtn.layer.cornerRadius = 5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldChageAction:) name:UITextFieldTextDidChangeNotification object:nil];

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
- (IBAction)agreeBtnDown:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        _agreeNum = 1;
    }else{
        _agreeNum = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerBtnDown:(id)sender {
    [_phoneTF resignFirstResponder];
    [_pwTF resignFirstResponder];
    [_vcodeTF resignFirstResponder];
    [_inviteTF resignFirstResponder];
    NSString *phoneStr = _phoneTF.text;
    if(![MacroMethodObject validatePhoneNum:phoneStr]){
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    
    [self registerRequest];
}
- (IBAction)agreeInfoBtnDown:(UIButton *)sender {
    UIStoryboard *sB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    AgreeInfoViewController *vc = [sB instantiateViewControllerWithIdentifier:@"AgreeInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)registerRequest
{
    if (_agreeNum == 0) {
        [MacroMethodObject showHudTextinWindow:@"请阅读并同意用户注册协议"];
        return;
    }
    NSString *phoneStr = _phoneTF.text;
    NSString *pwStr = _pwTF.text;
    NSString *vcodeStr = _vcodeTF.text;
    NSString *invertStr = _inviteTF.text;
    if (vcodeStr.length != 6) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的验证码"];
        return;
    }
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    if (![MacroMethodObject validatePhoneNum:phoneStr]) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    

    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            

            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:Login_User_IsLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];            
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
        
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
}
#pragma mark 验证码保存 ---
- (IBAction)vcodeBtnDown:(id)sender {
    NSString *phoneStr = _phoneTF.text;
    if (![MacroMethodObject validatePhoneNum:phoneStr]) {
        [MacroMethodObject showHudTextinWindow:@"请输入正确的手机号"];
        return;
    }
    
    NSMutableDictionary *dicOne = [[NSMutableDictionary alloc] init];
    [dicOne setValue:phoneStr forKey:@"mobile"];
    [dicOne setValue:@"1" forKey:@"validateType"];
    [RequestHttp requestPOSTWithDic:dicOne requestSuccess:^(id result) {
        NSString *error = [NSString stringWithFormat:@"%@",result[@"error"]];
        if ([error isEqualToString:@"1"]) {
            // success
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
            [self saveCodeTime];
            [self starTimer];
        }else if([error isEqualToString:@"-102"]){
            [MacroMethodObject showHudTextinWindow:result[@"该手机号已经注册"]];
        }else{
            [MacroMethodObject showHudTextinWindow:result[@"msg"]];
        }
    } requestFailure:^{
        [MacroMethodObject showFailHudinWindow];
    }];
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
- (void)starTimer
{
    //初始化定时器
    self.codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}
- (void)stopTimer
{
    [self.codeTimer invalidate];
}
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
- (void)timerFired:(NSTimer *)timer //定时器
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
#pragma mark 验证码
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
