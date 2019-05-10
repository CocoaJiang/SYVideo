//
//  SYWriteViewController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYWriteViewController.h"

@interface SYWriteViewController ()

@end

@implementation SYWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写邀请码";
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    tipLabel.text = @"填写好友邀请码";
    
    [tipLabel sizeToFit];
    
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top).offset(40);
        
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        
    }];
    
    UITextField *textField  = [[UITextField alloc]init];
    
    textField.borderStyle = UITextBorderStyleNone;
    
    textField.font = [UIFont systemFontOfSize:14];
    
    textField.placeholder = @"请输入您的邀请码";
    
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(10);
        
        make.height.mas_equalTo(@40);
        
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    UIView *lineview = [Tools retunLineView];
    
    [self.view addSubview:lineview];
    
    [lineview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(self.view);
        
        make.height.mas_equalTo(@0.5);
        
        make.top.mas_equalTo(textField.mas_bottom).offset(4);
    }];
    
    UILabel *messagelabel = [[UILabel alloc]init];
    
    messagelabel.font  = [UIFont systemFontOfSize:12];
    
    messagelabel.text = @"填写邀请码可使自己获得更多特权";
    
    messagelabel.textColor = [UIColor lightGrayColor];
    
    [messagelabel sizeToFit];
    
    [self.view addSubview:messagelabel];
    
    [messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(textField);
        
        make.top.mas_equalTo(lineview.mas_bottom).offset(10);
    }];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [submitButton setBackgroundColor:KappBlue];
    
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitButton.layer.cornerRadius  = 22.5;
    
    submitButton.layer.masksToBounds = YES;
    
    [self.view addSubview:submitButton];
    
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        
        make.top.mas_equalTo(messagelabel.mas_bottom).offset(50);
        
        make.height.mas_equalTo(@45);
        
    }];
    
    
    submitButton.clickAction = ^(UIButton *button) {
      
        if ([textField.text isEmpty]) {
            
            [Tools showErrorWithString:@"请填写有效邀请码"];
            
            return ;
        }
        
        NSLog(@"OK");
        
        
    };
    
    
    
    
    
    
}



@end
