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
    _name.font = [UIFont systemFontOfSize:24];
    _videoClass.font = _videodiver.font = _vodeoActor.font = [UIFont systemFontOfSize:13];
    _log.font = [UIFont systemFontOfSize:12];
    _free.font = [UIFont systemFontOfSize:14];
    _fromLabel.font = [UIFont systemFontOfSize:11];
    
}

@end
