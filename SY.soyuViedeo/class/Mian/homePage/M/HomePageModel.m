//
//  HomePageModel.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"recommend":[recommendModel class],
             @"data":[data class],
             @"slide":recommendModel.self,
             };
}

@end

@implementation data

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"item_list":[item class]
             };
}


-(BOOL)isHaveCover{
    if ([self.cover.pic length]>0) {
        return YES;
    }else{
        return NO;
    }
}



-(BOOL)isHaveAdd{
    if ([self.ad.pic length]>0) {
        return YES;
    }else{
        return NO;
    }
}



@end

@implementation SYad

@end


@implementation cover

@end


@implementation item

@end

@implementation recommendModel

@end
