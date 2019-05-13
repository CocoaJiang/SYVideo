//
//  SeachView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SeachView.h"

@implementation SeachView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.button setBackgroundColor:KAPPMAINCOLOR];
    self.button.layer.cornerRadius=5;
    self.button.layer.masksToBounds=YES;
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
}

@end
