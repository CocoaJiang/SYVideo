//
//  SYMonkeyTopView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMonkeyTopView.h"

@implementation SYMonkeyTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = KAPPMAINCOLOR;
    self.disLanel.text = [NSString stringWithFormat:@"%@余额",[SYUSERINFO info].systemModel.coin_name];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"littleGold"];
    attachment.bounds = CGRectMake(0, 0, 12, 12);
    NSMutableAttributedString *attriedString = (NSMutableAttributedString *)[Tools ReturnWithString:@"0" andWithColor:[UIColor whiteColor] andWithFont:30 andWithString:@" " andWithColor:[UIColor whiteColor] andWithFont:22];
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriedString insertAttributedString:stringImage atIndex:attriedString.length];
    self.monkeyLabel.attributedText = attriedString;
    
    self.makeMonkeyButton.layer.cornerRadius=15;
    self.makeMonkeyButton.layer.masksToBounds=YES;
    self.makeMonkeyButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.makeMonkeyButton.layer.borderWidth = 0.5f;
    
    _disLanel.font = [UIFont systemFontOfSize:12];
    _makeMonkeyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
}
- (IBAction)makeMonkey:(UIButton *)sender {
    [[Tools viewController:self].navigationController popViewControllerAnimated:YES];
}

-(void)setCoinsWithCoins:(NSString *)coins{
    if ([coins isEmpty]||coins==nil) {
        coins = @"0";
    }
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"littleGold"];
    attachment.bounds = CGRectMake(0, 0, 12, 12);
    NSMutableAttributedString *attriedString = (NSMutableAttributedString *)[Tools ReturnWithString:coins andWithColor:[UIColor whiteColor] andWithFont:30 andWithString:@" " andWithColor:[UIColor whiteColor] andWithFont:22];
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriedString insertAttributedString:stringImage atIndex:attriedString.length];
    self.monkeyLabel.attributedText = attriedString;

}


@end
