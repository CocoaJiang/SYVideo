//
//  C_SYcollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "C_SYcollectionViewCell.h"

@implementation C_SYcollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.name.font  = [UIFont systemFontOfSize:14];
     self.disLanel.font = [UIFont systemFontOfSize:13];
    _icon.contentMode =  UIViewContentModeScaleAspectFill ;
    _icon.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
