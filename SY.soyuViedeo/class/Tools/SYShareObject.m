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




@implementation SYShareObject

+(void)shareWithController:(UIViewController *)controller andWithImage:(nullable UIImage *)image andWithUrl:(nullable NSString *)url andWithArray:(nonnull NSArray *)array{
    
}


- (void)shareBtnClick
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareToPlatformType:platformType dic:nil];
    }];
}




//分享到指定平台
- (void)shareToPlatformType:(UMSocialPlatformType)platformType dic:(NSDictionary *)dic {
    
    
    //创建分享消息对象
    
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:@"白猫视频,全网免费" descr:@"立即下载,热门影视随心看" thumImage:[UIImage imageNamed:@"ic_logo4"]];
    webObject.webpageUrl = [SYUSERINFO info].systemModel.shareURL;
    messageObject.shareObject = webObject;
    
    if (![self isInstall:platformType]) {
        return ;
    }
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        ;
        //分享失败
        if (error) {
            
            //         [ZQHelper showErrorHint:error.localizedDescription];
            
        }else{
            
        }
    }];
}

#pragma mark 判断是否安装分享平台
- (BOOL)isInstall:(UMSocialPlatformType)platformType {
    
    return [[UMSocialManager defaultManager] isInstall:platformType];
}


@end
