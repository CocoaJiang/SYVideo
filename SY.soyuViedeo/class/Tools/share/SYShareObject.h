//
//  SYShareObject.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SharePicBlock)(void);

@interface SYShareObject : NSObject
+(void)shareWithController:(nonnull UIViewController *)controller andWithImage:(nullable UIImage *)image andWithUrl:(nullable NSString *)url andWithArray:(nonnull NSArray *)shareArray andBlock:(nullable SharePicBlock)block;
+(void)shareWithImage:(nullable UIImage *)image andWithUrl:(nullable NSString *)url andWithController:(nonnull UIViewController *)controller andWithString:(nonnull NSString *)title;
@end

NS_ASSUME_NONNULL_END
