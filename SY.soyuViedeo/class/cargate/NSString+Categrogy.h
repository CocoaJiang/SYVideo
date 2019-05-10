//
//  NSString+Categrogy.h
//  PeopleHabit
//
//  Created by Andy on 2018/12/11.
//  Copyright © 2018 SMXK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Categrogy)
-(NSString*)getWholeUrl;
- (BOOL)isUserName;
/** 是否为密码 */
- (BOOL)isPassword;
/** 是否为邮箱 */
- (BOOL)isEmail;
/** 是否为网址 */
- (BOOL)isUrl;
/** 判断手机号 */
- (BOOL)isTelephone;
/** 是否为空 */
- (BOOL) isEmpty;
/** 判断身份号 */
- (BOOL) isidentityCard;
/** 判断验证码 */
- (BOOL)isCode;

- (BOOL)isValidUrl;
- (BOOL)isValidPhoneNum;
/*****银行卡*****/
- (BOOL) IsBankCard:(NSString *)cardNumber;
/******字符串拼接**********/
-(NSString *)add:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
