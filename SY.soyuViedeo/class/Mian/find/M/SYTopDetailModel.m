//
//  SYTopDetailModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/27.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTopDetailModel.h"

@implementation SYTopDetailModel

@end



//影视相关信息
@implementation info
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"vedio":[videoDetail class],
             };
}
@end

@implementation videoDetail
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"relate":[recommendDetail class],
             };
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Class":@"class",
             };
}

@end

@implementation recommendDetail


@end

//评论相关
@implementation comment
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[commentDetail class],
             };
}
@end

@implementation commentDetail

@end









