//
//  SYVideoClass.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYVideoClass : SYTableViewCell
@property(copy,nonatomic)void(^sendHeight)(CGFloat Allheight);
@property(strong,nonatomic)NSMutableArray *labelArray;

@end

NS_ASSUME_NONNULL_END
