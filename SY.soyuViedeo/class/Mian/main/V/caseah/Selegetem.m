//
//  Selegetem.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "Selegetem.h"
@interface Selegetem()

@property(strong,nonatomic)UIButton *leftButton;
@property(strong,nonatomic)UIButton *rightButton;
@property(strong,nonatomic)UIView *lineView_Ver;
@property(strong,nonatomic)UIView *lineView_Her;

@end


@implementation Selegetem

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.lineView_Ver];
        [self addSubview:self.lineView_Her];
        self.leftButton.selected=YES;
    }
    return self;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_leftButton setTitleColor:KAPPMAINCOLOR forState:UIControlStateSelected];
        [_leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftButton sizeToFit];
    }
    return _leftButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:KAPPMAINCOLOR forState:UIControlStateSelected];
        [_rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:15];

        [_rightButton sizeToFit];

    }
    return _rightButton;
}
-(UIView *)lineView_Her{
    if (!_lineView_Her) {
        _lineView_Her = [[UIView alloc]init];
        _lineView_Her.backgroundColor = KAPPMAINCOLOR;
    }
    return _lineView_Her;
}

-(UIView *)lineView_Ver{
    if (!_lineView_Ver) {
        _lineView_Ver = [[UIView alloc]init];
        _lineView_Ver.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView_Ver;
}
-(void)layoutSubviews{
    [self.lineView_Ver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(@1.2);
        make.height.mas_equalTo(@20);
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineView_Ver.mas_left).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView_Ver.mas_right).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.lineView_Her mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftButton.mas_left);
        make.right.mas_equalTo(self.leftButton.mas_right);
        make.top.mas_equalTo(self.leftButton.mas_bottom).offset(1);
        make.height.mas_equalTo(@1);
    }];
    
    CGRect rect = self.leftButton.frame;
    self.lineView_Her.frame = CGRectMake(rect.origin.x, rect.origin.y+2, rect.size.width, 1);
    
}

-(void)setTtile:(NSString *)leftTitle andRightTitle:(NSString *)rightTitle{
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
    [self layoutSubviews];
}

-(void)buttonClick:(UIButton *)button{
    if (button==self.leftButton) {
        [self turnLeft];
        if (self.buttonClick) {
            self.buttonClick(0);
        }
    }
    if (button==self.rightButton) {
        [self turnRight];
        if (self.buttonClick) {
            self.buttonClick(1);
        }
    }
}
-(void)turnLeft{
    self.rightButton.selected=NO;
    self.leftButton.selected=YES;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.leftButton.frame;
        self.lineView_Her.frame = CGRectMake(rect.origin.x, rect.origin.y+2+rect.size.height, rect.size.width, 1);
    }];
}
-(void)turnRight{
    self.rightButton.selected=YES;
    self.leftButton.selected=NO;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.rightButton.frame;
        self.lineView_Her.frame = CGRectMake(rect.origin.x, rect.origin.y+2+rect.size.height, rect.size.width, 1);
    }];
}


@end
