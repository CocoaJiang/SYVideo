//
//  SYLevelPointHeaderView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLevelPointHeaderView.h"

@implementation SYLevelPointHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.title.textColor = RGBA(201, 16, 61, 1);
    self.title.font = [UIFont boldSystemFontOfSize:15];
  
}

@end
