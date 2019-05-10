//
//  NSString+Seleted.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/26.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "NSString+Seleted.h"
#import <objc/runtime.h>

@implementation NSString (Seleted)
BOOL boolKey;

-(void)setIsSeleted:(BOOL)isSeleted{
    objc_setAssociatedObject(self, &boolKey, @(isSeleted), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(BOOL)isSeleted{
    NSNumber *t = objc_getAssociatedObject(self,&boolKey);
    return (BOOL)[t boolValue];
}

@end
