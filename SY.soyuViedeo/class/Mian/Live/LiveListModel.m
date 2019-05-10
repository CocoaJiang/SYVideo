//
//  LiveListModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "LiveListModel.h"

@implementation LiveListModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             };
}
/// 主键
+ (NSString *)xw_primaryKey {
    return @"ID";
}

/// 联合主键成员变量数组
//+ (NSArray<NSString *> *)xw_unionPrimaryKey {
//    return @[@"cardID",@"age"];
//}

/// 自定义表名
+ (NSString *)xw_customTableName {
    return @"LiveHistory";
}

@end
