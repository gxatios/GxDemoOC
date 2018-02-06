//
//  LoginViewController.h
//  GxDemoOC
//
//  Created by Gx on 2017/8/28.
//  Copyright © 2017年 gx. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LoginViewSuccessBlock) ();

@interface LoginViewController : BaseViewController

@property (nonatomic,copy) LoginViewSuccessBlock loginSuccessBlock;
@end
