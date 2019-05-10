//
//  SYPoPTitleView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYPoPTitleView.h"

@interface SYPoPTitleView ()
@property(strong,nonatomic)UILabel  *title;
@property(strong,nonatomic)UILabel *subTitle;
@property(strong,nonatomic)UIButton *closeButton;
@property(strong,nonatomic)UIView *lineView;
@end

@implementation SYPoPTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.title];
        [self addSubview:self.subTitle];
        [self addSubview:self.closeButton];
        self.lineView = [Tools retunLineView];
        [self addSubview:self.lineView];
    }
    return self;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont boldSystemFontOfSize:16];
        [_title sizeToFit];
    }
    return _title;
}

-(UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]init];
        _subTitle.font = [UIFont systemFontOfSize:13];
        _subTitle.textColor = [UIColor darkGrayColor];
        [_subTitle sizeToFit];
    }
    return _subTitle;
}
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(void)buttonclick:(UIButton *)button{
    if (self.close) {
        self.close();
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(38,38 ));
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(10);
    }];
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.title.mas_right).offset(10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@0.4);
    }];
    
}

-(void)setTitle_string:(NSString *)title_string{
    _title_string = title_string;
    self.title.text = title_string;
}

-(void)setSubtitle_string:(NSString *)subtitle_string{
    _subtitle_string = subtitle_string;
    self.subTitle.text = subtitle_string;
}




@end
