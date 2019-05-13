//
//  SYNewLoginViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYNewLoginViewController.h"
#import "SYLoginPhoneInputView.h"
#import "SYNewPassWorldORVerCodeInPutView.h"
#import "UIButton+VerificationCode.h"
#import "SYnewRegisController.h"

@interface SYNewLoginViewController ()
@property(strong,nonatomic)SYLoginPhoneInputView *loginView;
@property(strong,nonatomic)SYNewPassWorldORVerCodeInPutView *passWorldView;
@property(strong,nonatomic)UIButton *button;
@property(strong,nonatomic)UIButton *loginButton;
@property(strong,nonatomic)UIButton *quickLogin;




@end

@implementation SYNewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    self.passWorldView.type = PassWorld;
    [self addUI];
}

-(void)setNAV{
    self.title = @"登录";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= item;
}

-(void)regis{
    SYnewRegisController *controller = [[SYnewRegisController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)addUI{
    [self.view addSubview:self.loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(40);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@50);
    }];
    [self.view addSubview:self.passWorldView];
    [_passWorldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.loginView);
        make.top.mas_equalTo(self.loginView.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.button setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.button sizeToFit];
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.passWorldView.right).offset(-10);
        make.top.mas_equalTo(self.passWorldView.mas_bottom).offset(20);
    }];
    
   [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:KAPPMAINCOLOR];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.loginButton sizeToFit];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 20;
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.loginView);
        make.top.mas_equalTo(self.button.mas_bottom).offset(50);
        make.height.mas_equalTo(@40);
    }];
    [self.loginButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.quickLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.quickLogin setTitle:@"快速登录" forState:UIControlStateNormal];
    [self.quickLogin setTitle:@"密码登录" forState:UIControlStateSelected];
    [self.quickLogin setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    self.quickLogin.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.quickLogin sizeToFit];
    [self.view addSubview:self.quickLogin];
    [self.quickLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(20);
        
    }];
    
    [self.quickLogin addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - 懒加载。。。
-(SYLoginPhoneInputView *)loginView{
    if (!_loginView) {
        _loginView = [Tools XJ_XibWithName:@"SYLoginPhoneInputView"];
    }
    return _loginView;
}

-(SYNewPassWorldORVerCodeInPutView *)passWorldView{
    if (!_passWorldView) {
        
        __weak typeof(self)weakSelf = self;
        _passWorldView = [Tools XJ_XibWithName:@"SYNewPassWorldORVerCodeInPutView"];
        _passWorldView.sendVerCode = ^{
            [weakSelf senCode];
        };
    }
    return _passWorldView;
}


#pragma mark - 点击事件
-(void)buttonClick:(UIButton *)button{
    if (button == self.quickLogin) {
        button.selected = !button.selected;
        if (button.selected) {
            self.passWorldView.type = 1;
        }else{
            self.passWorldView.type=0;
        }
    }else if (button==self.loginButton){
        if (self.passWorldView.type==0) { ///账号密码形式
            [self passWorldLogin];
        }else{
            [self verLogin];
        }
    }
}

-(void)passWorldLogin{
    
    if ([self.loginView.textField.text isEmpty]) {
        [Tools showErrorWithString:self.loginView.textField.placeholder];
        return;
    }
    if (![self.loginView.textField.text isTelephone]) {
        [Tools showErrorWithString:@"请您填写正确的手机号码"];
        return;
    }
    if ([self.passWorldView.textField.text isEmpty]) {
        [Tools showStatusWithString:self.passWorldView.textField.placeholder];
        return;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.loginView.textField.text forKey:@"user_name"];
    [dict setObject:[NSString md5HexDigest:self.passWorldView.textField.text] forKey:@"user_pwd"];
    [HttpTool POST:[SY_login getWholeUrl] param:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        userInfo *info = [userInfo mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        SYUSERINFO *sy = [SYUSERINFO info];
        sy.userInfo = info;
        USERDEFAULT_SET_value(info.user_name, KUSER_NAME); //储存密码
        USERDEFAULT_SET_value(info.user_code, KUSER_CODE);//存储默认上级ID；
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
    } error:^(NSString *error) {
        
    }];
}


-(void)verLogin{
    if ([self.loginView.textField.text isEmpty]) {
        [Tools showErrorWithString:self.loginView.textField.placeholder];
        return;
    }
    if (![self.loginView.textField.text isTelephone]) {
        [Tools showErrorWithString:@"请您填写正确的手机号码"];
        return;
    }
    if ([self.passWorldView.textField.text isEmpty]) {
        [Tools showStatusWithString:self.passWorldView.textField.placeholder];
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.loginView.textField.text forKey:@"mobile"];
    [dict setObject:self.passWorldView.textField.text forKey:@"code"];
    [HttpTool POST:[SY_loginFast getWholeUrl] param:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        userInfo *info = [userInfo mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        SYUSERINFO *sy = [SYUSERINFO info];
        sy.userInfo = info;
        USERDEFAULT_SET_value(info.user_name, KUSER_NAME); //储存密码
        USERDEFAULT_SET_value(info.user_code, KUSER_CODE);//存储默认上级ID；
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginSuccess" object:nil];
    } error:^(NSString *error) {
        
    }];
    
}

-(void)senCode{
    if ([self.loginView.textField.text isEmpty]) {
        [Tools showErrorWithString:self.loginView.textField.placeholder];
        return;
    }
    if (![self.loginView.textField.text isTelephone]) {
        [Tools showErrorWithString:@"请您填写正确的手机号码"];
        return;
    }
    [_passWorldView.vercodeButton startCountDown];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.loginView.textField.text forKey:@"mobile"];
    [HttpTool POST:[SY_smsCode getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showStatusWithString:@"短信已发出,请注意查收"];
    } error:^(NSString *error) {
        NSLog(@"%@",error.localizedLowercaseString);
    }];
}

@end
