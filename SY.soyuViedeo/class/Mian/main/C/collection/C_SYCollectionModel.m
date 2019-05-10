//
//  C_SYCollectionModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "C_SYCollectionModel.h"

@implementation C_SYCollectionModel
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"data":[C_itemModel class]
             };
}
@end

@implementation C_itemModel

@end
