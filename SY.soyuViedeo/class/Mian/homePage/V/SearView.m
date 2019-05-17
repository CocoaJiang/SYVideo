//
//  SearView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SearView.h"


@interface SearView ()
@property(strong,nonatomic)UIButton *listenButton;
@end
@implementation SearView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KTEXTFIELDBACKGROUNDCOLOR;
        [self addSubview:self.searButton];
        [self addSubview:self.listenButton];
        self.layer.masksToBounds =YES;
        self.layer.cornerRadius = 15;
        [self.listenButton setHidden:YES];
    }
    return self;
}
-(UIButton *)listenButton{
    if (!_listenButton) {
        _listenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listenButton setImage:[UIImage imageNamed:@"麦克风"] forState:UIControlStateNormal];
        [_listenButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_listenButton sizeToFit];
    }
    return _listenButton;
}
-(UIButton *)searButton{
    if (!_searButton) {
        _searButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_searButton setImage:[UIImage imageNamed:@"搜索2"] forState:UIControlStateNormal];
        _searButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_searButton sizeToFit];
        [_searButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searButton;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_listenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_searButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}
-(void)buttonClick:(UIButton *)button{
    if (self.listenButton) {
        self.listenBlock();
    }
}
-(void)search{
    if (self.searchBlock) {
        self.searchBlock();
    }
}

@end
