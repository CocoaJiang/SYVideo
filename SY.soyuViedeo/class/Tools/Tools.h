//
//  Tools.h
//  IntelligentFire
//
//  Created by Andy on 2018/8/19.
//  Copyright © 2018年 SMXK. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ImageBlock)(UIImage *image,NSURL *imageUrl);
typedef void(^MoreImageBlock)(NSArray *images);
typedef void(^MoreAttestBlock)(NSArray *attesArray);
typedef void(^ItemAction)(NSUInteger itemIndex);
typedef void(^Doanything)(void);
@interface Tools : NSObject
+ (void)moreImagePickerAtController:(UIViewController *)VC image:(MoreImageBlock)block :(NSInteger)maxCount;
+(void)XJ_morePickerController:(UIViewController *)controller image:(MoreImageBlock)block :(NSInteger)maxCount andSeletedArray:(NSMutableArray *)seltedArray andWithAttesBlock:(MoreAttestBlock)attsBlock;
+(void)showLoadStatusWithString:(NSString*)string;
+(void)showStatusWithString:(NSString*)string;
+(void)showSuccessWithString:(NSString *)scuess;
+(void)hideView;
+(void)showErrorWithString:(NSString*)errorString;
+ (UIViewController *)viewController:(UIView *)view;
+(id)XJ_XibWithName:(NSString *)xibName;
+(NSString *)alertText;
+(UIImage *)EmptyImage;
+(void)ShowLoading;
+(NSAttributedString *)returnWithString:(NSString *)string;
/*手机号隐藏*/
+(NSString *)returnBankCard:(NSString *)BankCardStr;
/*属性字符串双*/
+(NSAttributedString *)ReturnWithString:(NSString *)stringOne
                           andWithColor:(UIColor *)colorOne
                            andWithFont:(CGFloat)fontOne
                          andWithString:(NSString *)stringTwo
                           andWithColor:(UIColor *)colorTwo
                            andWithFont:(CGFloat)fontTwo;
/*单角切圆*/
+(void)setMaskTo:(UIView*)view
byRoundingCorners:(UIRectCorner)corners
    andWithCGSize:(CGSize )size;
/*计算字体大小传入字体*/
+(CGSize)XJCalculateTheSizeWithFont:(UIFont *)font andWithText:(NSString *)text andWithWidthMAX:(CGFloat)masW;
+(NSString *)retrunPriceWithPriceString:(NSString *)stringPrice;
+(NSString*)getCurrentTimes;
//写入文件
+(void)writeWithTokenWithString:(NSString *)string;
//读取token
+(NSString*)readToken;
+(BOOL)isNeedLogin;
//成功回调
+(void)showSuccess:(NSString *)success andWithDoEveryThingWithBlock:(Doanything)doEverything;
///失败的回调
+(void)showError:(NSString *)error andWithDoEveryThingWithBlock:(Doanything)doEverything;
//保存图片.....
+(void)saveImaheWihtImage:(UIImage *)image;
//制造一根线。
+(UIView *)retunLineView;
//获取设备的统一ID及UUID
+(NSString *)getUUID;
///生成二维码
+ (UIImage *)imageWithUrl:(NSString *)url imageSize:(CGFloat)size;
///删除ToKen..
+(void)deleteTokenFile;
@end
