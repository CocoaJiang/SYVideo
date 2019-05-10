//
//  SYHotPJTHeader.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYHotPJTHeader : UITableViewHeaderFooterView
@property(strong,nonatomic)UIButton *leftButton;
@property(strong,nonatomic)UIButton *rightButton;
@property(copy,nonatomic)void(^LeftClickOrRightClick)(NSString *title);
@end

NS_ASSUME_NONNULL_END
