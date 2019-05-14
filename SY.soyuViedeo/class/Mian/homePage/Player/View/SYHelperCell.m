//
//  SYHelperCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHelperCell.h"

@implementation SYHelperCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _title.font = _conten.font = [UIFont systemFontOfSize:14];
    _title.textColor = KAPPMAINCOLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
