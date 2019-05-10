//
//  HttpTool.h
//  PeopleHabit
//
//  Created by Andy on 2018/12/11.
//  Copyright © 2018 SMXK. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SucceedBlock)(id responseObject);
//typedef void(^ErrorBlock)(NSError *error);
typedef void(^ErrorBlock)(NSString *error);
NS_ASSUME_NONNULL_BEGIN

@interface HttpTool : NSObject
+ (void)POST:(NSString *)url param:(nullable NSDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback;

+(void)get:(NSString *)url param:(NSDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback;

+(void)upLoadmageData:(NSData *)imageData Url:(NSString *)url dict:(NSDictionary *)dic succed:(SucceedBlock)succed errorBlock:(ErrorBlock)errorBlock;
///不带加载框的加载。。。。
+ (void)NOACtionPOST:(NSString *)url param:(nullable NSMutableDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback;

@end

NS_ASSUME_NONNULL_END
