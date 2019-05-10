//
//  UIImageView+ZXJ_SD_SETIMAGE.m
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/12/26.
//  Copyright © 2018 双木科技张晓红. All rights reserved.
//

#import "UIImageView+ZXJ_SD_SETIMAGE.h"

@implementation UIImageView (ZXJ_SD_SETIMAGE)

-(void)XJ_setImageWithURLString:(NSString *)url_string{
    
    __weak typeof(self)weakSelf = self;
    if ([url_string hasPrefix:@"http://"]||[url_string hasPrefix:@"https://"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:url_string]placeholderImage:KDefaultImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image && cacheType==SDImageCacheTypeNone) {
                CATransition *transition = [CATransition animation];
                transition.type = kCATransitionFade;
                transition.duration = 0.3;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                [weakSelf.layer addAnimation:transition forKey:nil];
            }
        }];
    }else{
        [self sd_setImageWithURL:[NSURL URLWithString:[url_string getWholeUrl]] placeholderImage:KDefaultImage];
    }
}
-(void)XJ_setImageWithURLString:(NSString *)url_string andWithImageName:(NSString *)imageName{
    if ([url_string hasPrefix:@"http://"]||[url_string hasPrefix:@"https://"]) {
         __weak typeof(self)weakSelf = self;
        [self sd_setImageWithURL:[NSURL URLWithString:url_string]placeholderImage:KDefaultImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image && cacheType==SDImageCacheTypeNone) {
                CATransition *transition = [CATransition animation];
                transition.type = kCATransitionFade;
                transition.duration = 0.3;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                [weakSelf.layer addAnimation:transition forKey:nil];
            }
        }];
    }else{
        [self sd_setImageWithURL:[NSURL URLWithString:[url_string getWholeUrl]] placeholderImage:[UIImage imageNamed:imageName]];
   }
}



@end
