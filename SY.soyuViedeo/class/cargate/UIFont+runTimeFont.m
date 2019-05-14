//
//  UIFont+runTimeFont.m
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "UIFont+runTimeFont.h"
#import <objc/runtime.h>
#define MyUIScreen  375
@implementation UIFont (runTimeFont)
+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
    method_exchangeImplementations(class_getClassMethod([self class], @selector(boldAdjustFont:)), class_getClassMethod([self class], @selector(boldSystemFontOfSize:)));
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/MyUIScreen];
    return newFont;
}

+ (UIFont *)boldAdjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont boldAdjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/MyUIScreen];
    return newFont;
}



@end
