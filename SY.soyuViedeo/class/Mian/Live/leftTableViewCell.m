//
//  leftTableViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "leftTableViewCell.h"

@implementation leftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.lineView.backgroundColor = KAPPMAINCOLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
