//
//  SYTextTopView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTextTopView.h"
#import "SYHUView.h"


@interface SYTextTopView ()
@property(strong,nonatomic)SYHUView *huview;
@property(strong,nonatomic)UIButton *leftButton;
@property(strong,nonatomic)UIButton *rightButton;
@property(strong,nonatomic)UILabel *label;

@end

@implementation SYTextTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KappBlue;
        [self addSubview:self.huview];
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        [self addSubview:self.label];
    }
    return self;
}
-(SYHUView *)huview{
    if (!_huview) {
        _huview = [[SYHUView alloc]init];
        _huview.backgroundColor = KappBlue;
    }
    return _huview;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_huview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@25);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
        make.right.mas_equalTo(self.mas_centerX).offset(-35);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).offset(-10);
        make.left.mas_equalTo(self.mas_centerX).offset(35);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setTitle:@"我的邀请" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _leftButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _leftButton.layer.borderWidth = 0.5f;
        _leftButton.layer.masksToBounds=YES;
        _leftButton.layer.cornerRadius = 20;
        [_leftButton setImage:[UIImage imageNamed:@"myInvation"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
   
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"兑换中心" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _rightButton.layer.masksToBounds=YES;
        _rightButton.layer.cornerRadius = 20;
        [_rightButton setImage:[UIImage imageNamed:@"exchangeCenter"] forState:UIControlStateNormal];
        _rightButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightButton.layer.borderWidth = 0.5f;
        [_rightButton addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _rightButton;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        [_label sizeToFit];
    }
    return _label;
}

-(void)buttonclick:(UIButton *)button{
    if (self.topButtonClick) {
        self.topButtonClick(button.titleLabel.text);
    }
}
-(void)setType:(headerType)type{
    if (type==0) {
        self.leftButton.hidden=self.rightButton.hidden=NO;
        self.label.hidden=YES;
    }else{
        self.hidden=NO;
        self.leftButton.hidden=self.rightButton.hidden=YES;
    }
}

-(void)setLabelText:(NSString *)string{
    if ([string isEmpty]||string==nil) {
          string = @"0";
    }
    self.label.numberOfLines=0;
    self.label.textAlignment = NSTextAlignmentCenter;
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"littleGold"];
    attachment.bounds = CGRectMake(0, 0, 12, 12);
    NSString *coninst = [SYUSERINFO info].systemModel.coin_name? [SYUSERINFO info].systemModel.coin_name:@"金币";
    NSMutableAttributedString *attriedString = (NSMutableAttributedString *)[Tools ReturnWithString:[NSString stringWithFormat:@"%@余额\n\n",coninst] andWithColor:[UIColor whiteColor] andWithFont:13 andWithString:string andWithColor:[UIColor whiteColor] andWithFont:34];
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriedString insertAttributedString:stringImage atIndex:attriedString.length];
    self.label.attributedText = attriedString;
}



@end
