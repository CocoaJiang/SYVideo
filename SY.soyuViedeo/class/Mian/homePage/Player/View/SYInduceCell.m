//
//  SYInduceCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYInduceCell.h"

@implementation SYInduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.inducelabel.font = [UIFont systemFontOfSize:17];
    self.content.font = [UIFont systemFontOfSize:13];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
