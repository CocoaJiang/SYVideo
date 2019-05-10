//
//  SYCacheOperationHabit.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCacheOperationHabit.h"
#import "FLFMDBManager.h"
@implementation SYCacheOperationHabit
///存储操作习惯！！！！
+(USERSET *)getSetting{
    USERSET *set = [[FLFMDBManager shareManager:@"OperationHabit"]fl_searchModel:[USERSET class] byID:LocationOperationHabit];
    if (!set) {
        USERSET *set = [[USERSET alloc]init];
        set.FLDBID = LocationOperationHabit;
        set.autoPlay = @"0";
        set.continuity = @"1";
        set.cacheNum = @"1";
        set.hand = @"1";
        set.wifi = @"1";
        [[FLFMDBManager shareManager:@"OperationHabit"]fl_insertModel:set];
    }
    return  set;
}

+(BOOL)savaModelOperationHabit:(USERSET *)set{
    BOOL isSuccess = [[FLFMDBManager shareManager:@"OperationHabit"]fl_modifyModel:set byID:LocationOperationHabit];
    return isSuccess;
}




@end
