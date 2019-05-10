//
//  SYVideoPlayerCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTableViewCell.h"

@class  videoInfo;
NS_ASSUME_NONNULL_BEGIN

@interface SYVideoPlayerCell : SYTableViewCell
@property(copy,nonatomic)dispatch_block_t selection_item;
@property(assign,nonatomic)NSInteger index;
@property(strong,nonatomic)videoInfo *info;
@property(copy,nonatomic)void(^itemSetClick)(NSInteger index);





@end

NS_ASSUME_NONNULL_END
