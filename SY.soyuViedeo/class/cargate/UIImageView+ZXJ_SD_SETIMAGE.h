//
//  UIImageView+ZXJ_SD_SETIMAGE.h
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/12/26.
//  Copyright © 2018 双木科技张晓红. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZXJ_SD_SETIMAGE)
-(void)XJ_setImageWithURLString:(NSString *)url_string;
-(void)XJ_setImageWithURLString:(NSString *)url_string andWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
