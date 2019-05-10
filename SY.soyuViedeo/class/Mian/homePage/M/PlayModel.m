//
//  PlayModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/28.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "PlayModel.h"
#import "HomePageModel.h"



@implementation PlayModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"comment":[videoPlayercomment class],
             @"hot_comment":[videoPlayercomment class],
             @"recommend":[item class],
             };
}
@end

@implementation videoInfo

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Class":@"class",
             
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"url":[urlInfo class]
             };
}
@end


@implementation urlInfo

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[SYSet class]
             };
}

@end


@implementation SYSet

@end


@implementation videoPlayercomment

@end

@implementation play_record



@end
