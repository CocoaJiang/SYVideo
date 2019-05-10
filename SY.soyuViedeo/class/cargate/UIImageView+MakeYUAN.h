//
//  UIImageView+MakeYUAN.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (MakeYUAN)
-(void)MakeYuanWithScle:(double)scle;
-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;
@end

NS_ASSUME_NONNULL_END
