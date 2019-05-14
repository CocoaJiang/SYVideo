//
//  SYExchangeCenter.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYExchangeCenter.h"
#import "SY_exchange.h"
#define seletedColor RGBA(220,220,220,1)

@implementation SYExchangeCenter

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.exchangeButton.layer.cornerRadius=15;
    self.exchangeButton.layer.masksToBounds=YES;
    self.exchangeButton.layer.borderColor=KAPPMAINCOLOR.CGColor;
    self.exchangeButton.layer.borderWidth = 0.4f;
    [self.exchangeButton setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    [self.exchangeButton setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.exchangeButton setBackgroundColor:seletedColor forState:UIControlStateSelected];
    [self.exchangeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _monkeyLbal.font = _timeLanel.font = _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _title.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (self.buttonClick) {
        self.buttonClick(self.item.id);
    }
}

-(void)setItem:(SY_changItem *)item{
    _item  = item;
    [_icon XJ_setImageWithURLString:item.ico];
    _title.text = item.title;
    SYUSERINFO *userInfo = [SYUSERINFO info];
    _monkeyLbal.text = [NSString stringWithFormat:@"%@%@",item.coin,userInfo.systemModel.coin_name];
    _timeLanel.text = [NSString stringWithFormat:@"有效期:%@",item.valid_format];
    //判断可不可以兑换+点击+显示时间
    if (item.section==0) {
        self.exchangeButton.userInteractionEnabled = NO;
        self.exchangeButton.selected =  YES;
        [self.exchangeButton setTitle: [NSString stringWithFormat:@"%@天后到期",item.expiration] forState:UIControlStateSelected];
        self.exchangeButton.layer.borderColor = seletedColor.CGColor;
        [self.exchangeButton setTitleColor:KAPPMAINCOLOR forState:UIControlStateSelected];
        [_timeLanel setHidden:YES];
        [_monkeyLbal setHidden:YES];
    }else{
        [_timeLanel setHidden:NO];
        [_monkeyLbal setHidden:NO];
        self.exchangeButton.userInteractionEnabled = [item.is_exchange boolValue];
        self.exchangeButton.selected =![item.is_exchange boolValue];
        if (self.exchangeButton.selected) {
            [self.exchangeButton setTitle:@"余额不足" forState:UIControlStateSelected];
            self.exchangeButton.layer.borderColor = seletedColor.CGColor;
        }else{
            [self.exchangeButton setTitle:@"立即兑换" forState:UIControlStateSelected];
            self.exchangeButton.layer.borderColor = KAPPMAINCOLOR.CGColor;
        }
    }
    
    

    
    
}

@end
