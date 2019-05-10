//
//  SYEditHeaderItem.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEditHeaderItem.h"

@implementation SYEditHeaderItem

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = [UIColor clearColor];
    
    self.seletedImageView.hidden = YES;
    
}

@end
