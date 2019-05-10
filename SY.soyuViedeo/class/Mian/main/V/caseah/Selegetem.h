//
//  Selegetem.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Selegetem : UIView
@property(copy,nonatomic)void(^buttonClick)(NSInteger index);
-(void)setTtile:(NSString *)leftTitle andRightTitle:(NSString *)rightTitle;
-(void)turnLeft;
-(void)turnRight;
@end

NS_ASSUME_NONNULL_END
