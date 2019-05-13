//
//  SYRegisTwoViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYRegisTwoViewController.h"
#import "SYNewPassWorldORVerCodeInPutView.h"
#import "UIButton+VerificationCode.h"
@interface SYRegisTwoViewController ()
@property(strong,nonatomic)SYNewPassWorldORVerCodeInPutView *verCode;
@property(strong,nonatomic)SYNewPassWorldORVerCodeInPutView *passWorld;
@property(strong,nonatomic)UILabel *tipLal;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UIButton *loginButton;

@end
@implementation SYRegisTwoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.tipLal];
    [self.tipLal sizeToFit];
    [self.tipLal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(40);
    }];
    [self.view addSubview:self.phoneLabel];
    [self.phoneLabel sizeToFit];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.tipLal.mas_bottom).offset(20);
    }];
    [self.view addSubview:self.verCode];
    [self.verCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.phoneLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(@50);
    }];
    [self.view addSubview:self.passWorld];
    [self.passWorld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.verCode.mas_bottom);
        make.height.mas_equalTo(@50);
    }];
    self.verCode.textField.placeholder = @"请输入验证码";
    self.passWorld.textField.placeholder  = @"设置密码(6-12位数字或者字母)";
    
    
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:KAPPMAINCOLOR];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.loginButton sizeToFit];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 20;
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verCode.mas_left).offset(20);
        make.right.mas_equalTo(self.verCode.mas_right).offset(-20);
        make.top.mas_equalTo(self.passWorld.mas_bottom).offset(50);
        make.height.mas_equalTo(@40);
    }];
    [_loginButton addTarget:self action:@selector(buttonClicK:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    
    
    
}
-(SYNewPassWorldORVerCodeInPutView *)verCode{
    if (!_verCode) {
        _verCode = [Tools XJ_XibWithName:@"SYNewPassWorldORVerCodeInPutView"];
        _verCode.type = VerCode;
        [_verCode.vercodeButton addTarget:self action:@selector(buttonClicK:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verCode;
}
-(SYNewPassWorldORVerCodeInPutView *)passWorld{
    if (!_passWorld) {
        _passWorld = [Tools XJ_XibWithName:@"SYNewPassWorldORVerCodeInPutView"];
        _passWorld.type = PassWorld;
    }
    return _passWorld;
}
-(UILabel *)tipLal{
    if (!_tipLal) {
        _tipLal = [[UILabel alloc]init];
        _tipLal.text = @"请点击获取验证码至:";
        _tipLal.font = [UIFont systemFontOfSize:14];
        _tipLal.textColor = [UIColor redColor];
    }
    return _tipLal;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = [NSString stringWithFormat:@"+86  %@",[Tools returnBankCard:self.phone]];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor darkGrayColor];
    }
    return _phoneLabel;
}

-(void)buttonClicK:(UIButton *)button{
    if (_loginButton==button) {
        [self regis];
    }else{
        [_verCode.vercodeButton startCountDown];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:self.phone forKey:@"mobile"];
        [HttpTool POST:[SY_smsCode getWholeUrl] param:dict success:^(id responseObject) {
            [Tools showStatusWithString:@"短信已发出,请注意查收"];
        } error:^(NSString *error) {
            NSLog(@"%@",error.localizedLowercaseString);
        }];
    }
}

-(void)regis{
    //判断

    if ([self.verCode.textField.text isEmpty]) {
        [Tools showErrorWithString:self.verCode.textField.placeholder];
        return;
    }
    if ([self.passWorld.textField.text isEmpty]) {
        [Tools showErrorWithString:self.passWorld.textField.placeholder];
        return;
    }
    if ([self.passWorld.textField.text length]<6) {
        [Tools showErrorWithString:@"密码过短不规范"];
        return;
    }
    if ([self.passWorld.textField.text length]>12) {
        [Tools showErrorWithString:@"密码过长不规范"];
        return;
    }
    //如果都满足的话 去注册！
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.verCode.textField.text forKey:@"code"];
    [dict setObject:self.phone forKey:@"user_name"];
    //  NSString *md5String = [self.phonetextfield.text md5HexDigest];
    [dict setObject:[NSString md5HexDigest:self.passWorld.textField.text] forKey:@"user_pwd"];
    [HttpTool POST:[SY_register getWholeUrl] param:dict success:^(id responseObject) {
     ///执行登录  回退到个人中心
        [self login];

        
    } error:^(NSString *error) {
        NSLog(@"%@",error.localizedLowercaseString);
    }];
    

    
}

-(void)login{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.phone forKey:@"user_name"];
    [dict setObject:[NSString md5HexDigest:self.passWorld.textField.text] forKey:@"user_pwd"];
    [HttpTool POST:[SY_login getWholeUrl] param:dict success:^(id responseObject) {
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

@end
