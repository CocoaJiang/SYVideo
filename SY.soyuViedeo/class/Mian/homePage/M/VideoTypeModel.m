//
//  VideoTypeModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "VideoTypeModel.h"



@implementation VideoTypeModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"extends":[SY_Class class],
             @"list":[item class]
             };
}
@end

@implementation SY_Class
@end


