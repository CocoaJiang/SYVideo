//
//  LoginOutView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "LoginOutView.h"

@interface LoginOutView()
@property(strong,nonatomic)UIButton *button;
@end


@implementation LoginOutView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button];
        self.backgroundColor= [UIColor whiteColor];
    }
    return self;
}

-(UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.layer.cornerRadius=5;
        _button.backgroundColor = KappBlue;
        _button.layer.masksToBounds=YES;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitle:@"退出登录" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.left.mas_equalTo(self.mas_left).offset(40);
        make.right.mas_equalTo(self.mas_right).offset(-40);
        make.height.mas_equalTo(@45);
    }];
}
-(void)buttonClick:(UIButton *)button{
    if (self.loginOut) {
        self.loginOut();
    }
}






@end
