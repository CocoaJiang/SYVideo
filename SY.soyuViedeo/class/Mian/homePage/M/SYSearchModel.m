//
//  SYSearchModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchModel.h"

@implementation SYSearchModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[searchDetailModel class]
             };
}

@end


@implementation searchDetailModel

@end
