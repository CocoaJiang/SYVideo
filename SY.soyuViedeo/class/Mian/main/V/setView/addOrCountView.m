//
//  addOrCountView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "addOrCountView.h"

@implementation addOrCountView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.textField.userInteractionEnabled=NO;
    self.textField.layer.masksToBounds=YES;
    self.textField.layer.cornerRadius=25/2;
    self.textField.layer.borderColor = KAPPMAINCOLOR.CGColor;
    self.textField.layer.borderWidth = 1.0f;
    self.textField.textColor = KAPPMAINCOLOR;
    self.textField.textAlignment = NSTextAlignmentCenter;
}

- (IBAction)add:(UIButton *)sender {
    self.textField.text = [NSString stringWithFormat:@"%ld",[self.textField.text integerValue]+1];
    if (self.addOrdetion) {
        self.addOrdetion([self.textField.text integerValue]);
    }
    
}
- (IBAction)dution:(UIButton *)sender {
    if ([self.textField.text integerValue]<=1) {
        return;
    }
    self.textField.text = [NSString stringWithFormat:@"%ld",[self.textField.text integerValue]-1];
    if (self.addOrdetion) {
        self.addOrdetion([self.textField.text integerValue]);
    }
}

@end
