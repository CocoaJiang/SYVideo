//
//  SYMessageNotifel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMessageNotifel.h"

@interface SYMessageNotifel ()

@end

@implementation SYMessageNotifel

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title  = @"消息通知";
    
    self.view.backgroundColor = RGBA(240, 240, 240, 1);
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UILabel *label = [[UILabel alloc]init];
    
    [label sizeToFit];
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.textColor = [UIColor darkTextColor];
    
    label.text = @"消息通知";
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(view.mas_centerY);
        
        make.left.mas_equalTo(view.mas_left).offset(20);
    }];
    
    UILabel *rightlabel = [[UILabel alloc]init];
    
    [rightlabel sizeToFit];
    
    rightlabel.font = [UIFont systemFontOfSize:12];
    
    rightlabel.textColor = [UIColor lightGrayColor];
    
    rightlabel.text = @"已开启";
    
    [view addSubview:rightlabel];
    
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(view.mas_centerY);
        
        make.right.mas_equalTo(view.mas_right).offset(-20);
        
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    
    [tipLabel sizeToFit];
    
    tipLabel.font = [UIFont systemFontOfSize:13];
    
    tipLabel.textColor = [UIColor lightGrayColor];
    
    tipLabel.numberOfLines = 0;
    
    tipLabel.text = @"修改通知需前往系统设置中,麻花影视的消息通知中更改";
    
    [self.view addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(view.mas_left).offset(20);
       
        make.top.mas_equalTo(view.mas_bottom).offset(10);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"去设置" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [button setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(view.mas_left).offset(20);
        
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(10);
        
    }];
    
    
    button.clickAction = ^(UIButton *button) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    };
    
    
    
}




@end
