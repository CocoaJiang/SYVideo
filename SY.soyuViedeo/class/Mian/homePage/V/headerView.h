//
//  headerView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface headerView : UIView
-(void)setSingeleButton;
-(void)setTwoButton;
@property(copy,nonatomic)dispatch_block_t chose;




@end

NS_ASSUME_NONNULL_END
