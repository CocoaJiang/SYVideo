//
//  HttpTool.m
//  PeopleHabit
//
//  Created by Andy on 2018/12/11.
//  Copyright © 2018 SMXK. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "NSString+MD5String.h"
#import "SYUSERINFO.h"
@implementation HttpTool



+ (AFHTTPSessionManager *)defaultManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *reson = [AFJSONResponseSerializer serializer];
    reson.removesKeysWithNullValues = YES;
    reson.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    manager.responseSerializer = reson;
    manager.requestSerializer.timeoutInterval =30.0f;
    return manager;
}
+ (void)POST:(NSString *)url param:(NSMutableDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback
{
    
    [Tools ShowLoading];
    AFHTTPSessionManager *manager = [self defaultManager];
    NSMutableDictionary *dict = [self removeStringKeys:param];
    NSMutableArray *descArray = [self descWithDict:dict];
    NSMutableString *mutableString = [self returnStringwithKeys:descArray andWithParam:dict];
    NSString *str_up = [self returnScoreStringwtihString:mutableString];
    [dict setObject:str_up forKey:@"sign"];
    if ([[Tools readToken] length]>0) {
        url = [NSString stringWithFormat:@"%@?token=%@",url,[Tools readToken]];
    }
    NSString *url_f8 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:url_f8 parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue]==0) {
            if ([[responseObject objectForKey:@"token"] length]>0) {
                [Tools writeWithTokenWithString:[responseObject objectForKey:@"token"]];
            }
            if (successCallback) {
                successCallback(responseObject);
            }
             [Tools hideView];
        }else if ([[responseObject objectForKey:@"code"] integerValue] == 4100){
            __weak typeof(self)weakSelf = self;
            [Tools showError:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                [weakSelf tokenFailure];
            }];
        }else{
             [Tools hideView];
            [Tools showErrorWithString:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            if (errorCallback) {
                errorCallback(error.localizedDescription);
            }
            [Tools hideView];
        }
    }];
    
}

+(void)get:(NSString *)url param:(NSDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback{
 //   AFHTTPSessionManager *manager = [self defaultManager];
    
//    NSString *url_f8 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    manager.requestSerializer.timeoutInterval = 20.0f;
//    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (successCallback) {
//            successCallback(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (error) {
//
//            if (errorCallback) {
//                errorCallback(error.localizedDescription);
//            }
//        }
//    }];
    
}
+(void)upLoadmageData:(NSData *)imageData Url:(NSString *)url dict:(NSDictionary *)dic succed:(SucceedBlock)succed errorBlock:(ErrorBlock)errorBlock
{
//    [ZQHelper showLoadHint:@"加载中。。。"];
//    AFHTTPSessionManager *manager = [self defaultManager];
//    NSString *url_f8 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    manager.requestSerializer.timeoutInterval = 20.0f;
//
//    [manager POST:url_f8 parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFileData:imageData name:@"file" fileName:@"image.png" mimeType:@"image/png"];
//
//        NSLog(@"%@",formData);
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (succed) {
//
//            [ZQHelper dismiss];
//
//            succed (responseObject);
//
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        [ZQHelper showErrorHint:error.localizedDescription];
//
//        if (errorBlock) {
//
//            errorBlock(error.localizedDescription);
//        }
//
//    }];
    
}


+ (void)NOACtionPOST:(NSString *)url param:(NSMutableDictionary *)param success:(SucceedBlock)successCallback error:(ErrorBlock)errorCallback
{
    AFHTTPSessionManager *manager = [self defaultManager];
    NSMutableDictionary *dict = [self removeStringKeys:param];
    NSMutableArray *descArray = [self descWithDict:dict];
    NSMutableString *mutableString = [self returnStringwithKeys:descArray andWithParam:dict];
    NSString *str_up = [self returnScoreStringwtihString:mutableString];
    [dict setObject:str_up forKey:@"sign"];
    if ([[Tools readToken] length]>1) {
        url = [NSString stringWithFormat:@"%@?token=%@",url,[Tools readToken]];
    }
    NSString *url_f8 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:url_f8 parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue]==0) {
            if ([[responseObject objectForKey:@"token"] length]>0) {
                [Tools writeWithTokenWithString:[responseObject objectForKey:@"token"]];
            }
            if (successCallback) {
                successCallback(responseObject);
            }
        }else if ([[responseObject objectForKey:@"code"] integerValue]==4100){
            __weak typeof(self)weakSelf = self;
            [Tools showError:[responseObject objectForKey:@"message"] andWithDoEveryThingWithBlock:^{
                [weakSelf tokenFailure];
            }];
        }else{
            [Tools showErrorWithString:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            if (errorCallback) {
                errorCallback(error.localizedDescription);
            }
        }
    }];
    
}


///
///第一步移除关键字并添加关键字
+(NSMutableDictionary *)removeStringKeys:(NSMutableDictionary *)param{
    if (!param) {
        param = [[NSMutableDictionary alloc]init];
    }
    if ([param.allKeys containsObject:@"timestamp"]) {
        [param removeObjectForKey:@"timestamp"];
    }
    if ([param.allKeys containsObject:@"sign"]) {
        [param removeObjectForKey:@"sign"];
    }
    NSString *string_times = [NSString stringWithFormat:@"%@",[Tools getCurrentTimes]];
    [param setObject:string_times forKey:@"timestamp"];
    return param;
}


///简直生序排序
+(NSMutableArray *)descWithDict:(NSMutableDictionary *)param{
    NSMutableArray *array_keys = [[NSMutableArray alloc]init];
    [array_keys addObjectsFromArray:param.allKeys];
    for (int i = 0; i<array_keys.count-1; i++) {
        for (int j=0; j<array_keys.count-i-1; j++) {
            if ([array_keys[j] compare:array_keys[j+1]] == NSOrderedDescending) {
                [array_keys exchangeObjectAtIndex:j withObjectAtIndex:(j + 1)];
            }
        }
    }
    return array_keys;
}

///第三步进行拼接Key和Values 需要处理数组模式下的递归方式
+(NSMutableString *)returnStringwithKeys:(NSMutableArray *)array_keys andWithParam:(NSMutableDictionary *)param{
    NSMutableString *mutableString = [NSMutableString string];
    for (int i = 0; i<array_keys.count; i++) {
        NSString *string_key  = array_keys[i];
        id  value = [param objectForKey:string_key];
        if ([value isKindOfClass:[NSArray class]]) {
            NSString *varString = [self appStringWithKey:mutableString andWithValues:(NSArray *)value];
            varString = [NSString stringWithFormat:@"%@%@",string_key,varString];
            [mutableString appendString:varString];
        }else{
            
            [mutableString appendFormat:@"%@", string_key];
             [mutableString appendFormat:@"%@",(NSString *)value]; //大多数情况下走的是这条路
        }
    }
  
    return mutableString;
}

///第三步遇到数组情况下拼接字符串。。。。
+(NSString *)appStringWithKey:(NSMutableString *)key andWithValues:(NSArray *)values{
    NSMutableString *varString = [NSMutableString string];
    [varString appendString:key];
    for (int i = 0; i<[values count]; i++) {
        id value = values[i];
        if ([value isKindOfClass:[NSArray class]]) {
             [self appStringWithKey:key andWithValues:(NSArray *)value];
        }else{
            [varString appendFormat: @"%i%@",i,(NSString *)value];
        }
    }
    
    varString = (NSMutableString *)[self returnScoreStringwtihString:varString];
    
    return varString;
}

///重新再一次加密
+(NSString *)returnScoreStringwtihString:(NSMutableString *)mutableString{
    //第三步 上一步得到的字符md5加密
    NSString *string = [NSString md5HexDigest:mutableString];
    //第四步 上一步加密字符+key
    NSString *key_strinhg = [NSString stringWithFormat:@"%@28c8edde3d61a0411611d3b1866f0636",string];
    //第五步 再一次MD5
    NSString *MD5_string = [NSString md5HexDigest:key_strinhg];
    //第六步转换成大写。
    NSString *str_up = [MD5_string uppercaseString];
    return str_up;
}

////token 失效应该做的事情
+(void)tokenFailure{
    //1.删除Token文件。。。。。
    [Tools deleteTokenFile];
    //2.清除用户信息。。。。。。
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:KUSER_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KUSER_CODE];
    //3.如果不行的话就发通知到Base、、、、、
}







@end
