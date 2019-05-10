//
//  SYnewRegisController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYnewRegisController.h"
#import "SYLoginPhoneInputView.h"
#import "SYRegisTwoViewController.h"

@interface SYnewRegisController ()
@property(strong,nonatomic)UIButton *loginButton;
@property(strong,nonatomic)SYLoginPhoneInputView *loginView;
@property(strong,nonatomic)UIButton *agreeButton;
@property(strong,nonatomic)UIButton *redButton;



@end

@implementation SYnewRegisController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNAV];
    [self addUI];
    
}

-(void)setNAV{
    self.title = @"注册";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button sizeToFit];
    UIBarButtonItem *item  = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem= item;
}

-(void)regis{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addUI{
    [self.view addSubview:self.loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(40);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@50);
    }];
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:@"下一步" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:KappBlue];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.loginButton sizeToFit];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 20;
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginView.mas_left).offset(20);
        make.right.mas_equalTo(self.loginView.mas_right).offset(-20);
        make.top.mas_equalTo(self.loginView.mas_bottom).offset(50);
        make.height.mas_equalTo(@40);
    }];
    [self.loginButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.agreeButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.agreeButton setTitle:@"我已阅读并同意" forState:UIControlStateNormal];
    [self.agreeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.agreeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.agreeButton sizeToFit];
    [self.agreeButton setImage:[UIImage imageNamed:@"noreadwhite"] forState:UIControlStateNormal];
    [self.agreeButton setImage:[UIImage imageNamed:@"readwhite"] forState:UIControlStateSelected];
    [self.view addSubview:self.agreeButton];
    [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginButton);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(20);
    }];
    [self.agreeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.redButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.redButton setTitle:@"《用户注册协议》" forState:UIControlStateNormal];
    [self.redButton setTitleColor:KappBlue forState:UIControlStateNormal];
    self.redButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.redButton sizeToFit];
    [self.view addSubview:self.redButton];
    [self.redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.agreeButton.mas_centerY);
        make.left.mas_equalTo(self.agreeButton.mas_right);
    }];
    [self.redButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

}
-(SYLoginPhoneInputView *)loginView{
    if (!_loginView) {
        _loginView = [Tools XJ_XibWithName:@"SYLoginPhoneInputView"];
    }
    return _loginView;
}

-(void)buttonClick:(UIButton *)button{
    if (button==self.agreeButton) {
        button.selected = !button.selected;
    }else if (button==self.loginButton){
        if ([self.loginView.textField.text isEmpty]) {
            [Tools showErrorWithString:self.loginView.textField.placeholder];
            return;
        }
        if (![self.loginView.textField.text isTelephone]) {
            [Tools showErrorWithString:@"请您填写正确的手机号码"];
            return;
        }
        if (!self.agreeButton.selected) {
            [Tools showStatusWithString:@"请阅读并同意注册协议"];
            return;
        }
        SYRegisTwoViewController *controller = [[SYRegisTwoViewController alloc]init];
        controller.phone = self.loginView.textField.text;
        [self.navigationController pushViewController:controller animated:YES];
    }
}


@end
