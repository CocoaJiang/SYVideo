//
//  SYPoPTitleView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYPoPTitleView : UIView
@property(copy,nonatomic)NSString *title_string;
@property(copy,nonatomic)NSString *subtitle_string;
@property(copy,nonatomic)dispatch_block_t close;


@end

NS_ASSUME_NONNULL_END
