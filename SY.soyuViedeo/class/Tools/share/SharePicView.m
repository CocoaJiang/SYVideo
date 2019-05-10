//
//  SharePicView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SharePicView.h"

@implementation SharePicView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.pic.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pic.layer.borderWidth = 0.4f;
}

@end
