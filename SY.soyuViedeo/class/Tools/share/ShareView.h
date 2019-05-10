//
//  ShareView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/29.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView
@property(strong,nonatomic)NSArray *shareArray;
@property(copy,nonatomic)dispatch_block_t cancel;
@property(copy,nonatomic)void(^choseItem)(NSString *title);
@end

NS_ASSUME_NONNULL_END
