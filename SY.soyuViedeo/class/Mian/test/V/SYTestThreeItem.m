//
//  SYTestThreeItem.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/20.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTestThreeItem.h"

@interface SYTestThreeItem ()

@end


@implementation SYTestThreeItem

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addTitleForButtonWithButton:self.invatebutton andWithStr:@"已经邀请\n\n0人"];
    [self addTitleForButtonWithButton:self.monkeyButton andWithStr:@"搜云币\n\n0个"];
    [self addTitleForButtonWithButton:self.qiandaoButton andWithStr:@"连续签到\n\n0天"];
}

-(void)addDataWithInvateButtonCount:(NSString *)intvateCount andWithMonkey:(NSString *)MonkeyCount andWithQianDaoDays:(NSString *)daysCount{
    [self addTitleForButtonWithButton:self.invatebutton andWithStr:[NSString stringWithFormat:@"已经邀请\n\n%@人",intvateCount]];
    [self addTitleForButtonWithButton:self.monkeyButton andWithStr:[NSString stringWithFormat:@"%@\n\n%@个",[SYUSERINFO info].systemModel.coin_name,MonkeyCount]];
    [self addTitleForButtonWithButton:self.qiandaoButton andWithStr:[NSString stringWithFormat:@"连续签到\n\n%@天",daysCount]];

}




-(void)addTitleForButtonWithButton:(UIButton *)button andWithStr:(NSString *)str{
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.numberOfLines=0;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    //细节优化………………
    NSAttributedString *attributedString = [Tools ReturnWithString:[str substringToIndex:[str length]-1] andWithColor:[UIColor darkTextColor] andWithFont:15 andWithString:[str substringFromIndex:[str length]-1] andWithColor:[UIColor darkTextColor] andWithFont:10];
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];

}


- (IBAction)buttonClick:(UIButton *)sender {
    if (sender == self.monkeyButton) {
        if (self.buttonClick) {
            self.buttonClick(1);
        }
    }else{
        if (self.buttonClick) {
            self.buttonClick(0);
        }
    }
}


@end
