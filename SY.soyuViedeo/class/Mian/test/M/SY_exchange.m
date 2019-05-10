//
//  SY_exchange.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SY_exchange.h"

@implementation SY_exchange
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"list":[SY_changItem class],
             @"record":[SY_changItem class]
             };
}
@end

@implementation SY_changItem

@end
