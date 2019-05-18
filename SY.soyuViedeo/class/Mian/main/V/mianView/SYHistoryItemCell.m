//
//  SYHistoryItemCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYHistoryItemCell.h"

@implementation SYHistoryItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.VideoName.font = self.progress.font = [UIFont systemFontOfSize:13];
    _iCon.contentMode = UIViewContentModeScaleAspectFill;
    _iCon.clipsToBounds = YES;
}

@end
