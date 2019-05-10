//
//  SYUSERINFO.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYUSERINFO.h"

@implementation SYUSERINFO

static SYUSERINFO *sy = nil;
+ (SYUSERINFO *)shareTools
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sy = [[super allocWithZone:NULL] init];
    });
    return sy;
}
+(instancetype)info{
    return [self shareTools];
}


@end
