//
//  SYZanCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYZanCell.h"

@implementation SYZanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.faceOn.layer.cornerRadius=14;
    self.faceOn.layer.masksToBounds=YES;
    self.faceOn.layer.borderColor = KAPPMAINCOLOR.CGColor;
    self.faceOn.layer.borderWidth=0.4f;
    [self.icon MakeYuanWithScle:20.0f];
    [self.faceOn setTitle:@"关注" forState:UIControlStateNormal];
    [self.faceOn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.faceOn setTitleColor:KAPPMAINCOLOR forState:UIControlStateNormal];
    [self.faceOn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
 
    [self.faceOn setBackgroundColor:KAPPMAINCOLOR forState:UIControlStateSelected];
    [self.faceOn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}



@end
