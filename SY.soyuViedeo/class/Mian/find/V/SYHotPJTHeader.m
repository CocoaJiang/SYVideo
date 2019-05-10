//
//  SYHotPJTHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotPJTHeader.h"

@interface SYHotPJTHeader ()

@end
@implementation SYHotPJTHeader

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.leftButton];
        [self.contentView addSubview:self.rightButton];
        self.leftButton.selected = YES;
    }
    return self;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"最新" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"最热" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightButton;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftButton.mas_right).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

-(void)buttonClick:(UIButton *)button{
    if (button.selected) {
        return;
    }
    button.selected = !button.selected;
    if (button.selected) {
        button.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    if (button==self.leftButton) {
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.rightButton.selected=NO;
    }else{
        self.leftButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.leftButton.selected=NO;

    }
    if (self.LeftClickOrRightClick) {
        self.LeftClickOrRightClick(button.titleLabel.text);
    }
}


@end
