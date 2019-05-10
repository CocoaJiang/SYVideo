//
//  SYShareObject.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYShareObject.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>
#import "ZXJPopView.h"
#import "ShareView.h"
#import "SharePicController.h"



@implementation SYShareObject

+(void)shareWithController:(UIViewController *)controller andWithImage:(nullable UIImage *)image andWithUrl:(nullable NSString *)url andWithArray:(nonnull NSArray *)shareArray andBlock:(nullable SharePicBlock)block{
    
    ZXJPopView *popView = [[ZXJPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    popView.dismisBlock = ^{
        
        
    };
    
    CGFloat collectionHeight = [shareArray count]%4==0? 88*([shareArray count]/4):88*(([shareArray count]/4)+1);
    
    CGFloat height = iPhoneX ? collectionHeight+85+40:collectionHeight+85;
    
    ShareView *share = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+10)];
    
    share.shareArray = shareArray;
    
    popView.contentview = share;
    share.cancel  = ^{
        [popView dismissAlert];
    };
    
    share.choseItem = ^(NSString *title) {
        [popView dismissAlert];
        if ([title isEqualToString:@"分享图片"]) {
            if (block) {
                block();
            }
            
        }else{
            
            [self shareWithImage:image andWithUrl:url andWithController:controller andWithString:title];
            
        }
    };
    
    [popView showAlert];
    
    
    
}



+(void)shareWithImage:(nullable UIImage *)image andWithUrl:(nullable NSString *)url andWithController:(nonnull UIViewController *)controller andWithString:(nonnull NSString *)title{
    UMSocialPlatformType type;
    if ([title isEqualToString:@"朋友圈"]) {
        type = UMSocialPlatformType_WechatTimeLine;
    }else if ([title isEqualToString:@"微信"]){
        type = UMSocialPlatformType_WechatSession;
    }else if ([title isEqualToString:@"QQ"]){
        type = UMSocialPlatformType_QQ;
    }else if ([title isEqualToString:@"QQ空间"]){
        type = UMSocialPlatformType_Qzone;
    }else if ([title isEqualToString:@"微博"]){
        type = UMSocialPlatformType_Sina;
    }else {
        UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
        pastboard.string = url;
        [Tools showSuccessWithString:@"复制成功"];
        return ;
    }
    
    if (![self isInstall:type]) {
        
        [Tools showStatusWithString:@"您没有安装改款应用"];
        
        return;
        
    }
    
    [self shareToPlatformType:type andWithController:controller andWithURL:url andWithImage:image];
}
    




//分享到指定平台
+(void)shareToPlatformType:(UMSocialPlatformType)platformType andWithController:(UIViewController *)controller andWithURL:(NSString *)url andWithImage:(UIImage *)image{
    
    
    //创建分享消息对象
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (url) {
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:@"白猫视频,全网免费" descr:@"立即下载,热门影视随心看" thumImage:[UIImage imageNamed:@"ic_logo4"]];
        webObject.webpageUrl = url;
        messageObject.shareObject = webObject;
    }else{
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图本地
        shareObject.thumbImage = KDefaultImage;
        [shareObject setShareImage:image];
        [shareObject setTitle:@""];
        messageObject.shareObject = shareObject;
    }
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        ;
        //分享失败
        if (error) {
            
            [Tools showSuccessWithString:@"成功"];
            
        }else{
            
            [Tools showSuccessWithString:@"失败"];
            
        }
    }];
}

#pragma mark 判断是否安装分享平台
+(BOOL)isInstall:(UMSocialPlatformType)platformType {
    
    return [[UMSocialManager defaultManager] isInstall:platformType];
}


@end
