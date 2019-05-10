//
//  VideoPlayInfo.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "VideoPlayInfo.h"

@implementation VideoPlayInfo

/// 主键
+ (NSString *)xw_primaryKey {
    return @"FLDBID";
}

/// 联合主键成员变量数组
//+ (NSArray<NSString *> *)xw_unionPrimaryKey {
//    return @[@"cardID",@"age"];
//}

/// 自定义表名
+ (NSString *)xw_customTableName {
    return @"watchVideoHistory";
}

@end
