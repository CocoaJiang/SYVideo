//
//  ChoseHeaderCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "ChoseHeaderCell.h"

@implementation ChoseHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.header.layer.masksToBounds=YES;
    self.header.layer.cornerRadius=25.0f;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end
