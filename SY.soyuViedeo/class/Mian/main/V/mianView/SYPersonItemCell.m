//
//  SYPersonItemCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYPersonItemCell.h"
#import "SYTestController.h"
#import "SYTextCenterController.h"
#import "SYmonkeyHistory.h"
#import "SYShareController.h"
#import "SYNewLoginViewController.h"

@implementation SYPersonItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tests.titleLabel.font = self.gifts.titleLabel.font = self.addPerple.titleLabel.font = [UIFont systemFontOfSize:14];
 
    [self setUPDowdWitButton:self.tests];
    [self setUPDowdWitButton:self.gifts];
    [self setUPDowdWitButton:self.addPerple];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setUPDowdWitButton:(UIButton *)button{
    [button setUpImageAndDownLableWithSpace:10];
}

-(void)setPoints:(NSString *)points{
    _points = points;
    self.flowers.titleLabel.numberOfLines = 0;
    self.flowers.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.flowers.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    NSString *name = [SYUSERINFO info].systemModel.coin_name? [SYUSERINFO info].systemModel.coin_name:@"金币";
    NSAttributedString *attr = [Tools ReturnWithString:[NSString stringWithFormat:@"%@\n",name] andWithColor:[UIColor darkGrayColor] andWithFont:14 andWithString:[SYUSERINFO info].userInfo.user_points==nil?@"0":[SYUSERINFO info].userInfo.user_points andWithColor:[UIColor orangeColor] andWithFont:12];
    self.flowers.titleLabel.width = self.flowers.width;
    [self.flowers setAttributedTitle:attr forState:UIControlStateNormal];
       [self setUPDowdWitButton:self.flowers];

}

- (IBAction)buttonClick:(UIButton *)sender {
    if ([Tools isNeedLogin]) {
        [[Tools viewController:self].navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
        return;
    }
    
    if (sender==self.flowers) {
        [[Tools viewController:self].navigationController pushViewController:[SYmonkeyHistory new] animated:YES];
    }else if (sender ==self.tests){
        [[Tools viewController:self].navigationController pushViewController:[SYTestController new] animated:YES];
    }else if (sender==self.gifts){
        [[Tools viewController:self].navigationController pushViewController:[SYTextCenterController new] animated:YES];
    }else{
        [[Tools viewController:self].navigationController pushViewController:[SYShareController new] animated:YES];
    }
    
}


/*
 NSString *c = @"aaaa\nbbbccccc";
 NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:c];
 [aString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,4)];
 [aString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]range:NSMakeRange(4,4)];
 [aString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]range:NSMakeRange(8,c.length-8)];
 [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9]range:NSMakeRange(0, 4)];
 [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30]range:NSMakeRange(4, c.length-4)];
 UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 200, 90)];
 btn1.titleLabel.numberOfLines = 0;
 [btn1 setAttributedTitle:aString forState:UIControlStateNormal];
 //btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
 btn1.backgroundColor = [UIColor yellowColor];
 btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
 [self.view addSubview:btn1];
 */
@end
