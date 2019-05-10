//
//  SYlivePlayer.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYlivePlayer.h"


@implementation dayModel

@end

@implementation routeModel

@end


@implementation SYlivePlayer

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"day":[dayModel class],
             @"routes":[routeModel class]
             };
}

@end
