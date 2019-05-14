//
//  historyDetailCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "historyDetailCell.h"

@implementation historyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.font = [UIFont systemFontOfSize:14];
    self.dislabel.font = [UIFont systemFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
