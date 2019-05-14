//
//  MyOrderView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/10.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "MyOrderView.h"

@implementation MyOrderView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.orderButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    self.orderButton.layer.cornerRadius = 15;
    self.orderButton.layer.masksToBounds = YES;
    [self.orderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.orderButton setBackgroundColor:KAPPMAINCOLOR];
    _order.font  = [UIFont systemFontOfSize:17];
    _number.font= [UIFont boldSystemFontOfSize:26];
    _person.font = [UIFont systemFontOfSize:14];
    _orderButton.titleLabel.font = [UIFont systemFontOfSize:15];
}

@end
