//
//  NSString+MD5String.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/11.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5String)
+(NSString *)md5HexDigest:(NSString *)input;
@end

NS_ASSUME_NONNULL_END
