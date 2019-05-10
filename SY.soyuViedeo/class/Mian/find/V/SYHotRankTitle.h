//
//  SYHotRankTitle.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYHotRankTitle : UIView

@property(strong,nonatomic)NSArray *array;

@property(copy,nonatomic)void(^buttonClick)(NSString *title,NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame andWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
