//
//  NSString+MD5String.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "NSString+MD5String.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (MD5String)

+(NSString *)md5HexDigest:(NSString *)input{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];//%02意思是不足两位将用0补齐，如果多于两位则不影响,小写x表示输出小写，大写X表示输出大写
    }
    return ret;
}


@end
