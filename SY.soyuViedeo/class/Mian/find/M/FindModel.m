//
//  FindModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/26.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"data":[rankModel class]
             };
}
@end

@implementation rankModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"Class":@"class"
             };
}

@end

@implementation hotModel


@end
