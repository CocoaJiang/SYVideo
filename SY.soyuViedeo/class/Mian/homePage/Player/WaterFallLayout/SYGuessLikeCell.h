//
//  SYGuessLikeCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTableViewCell.h"

@class PlayModel;

NS_ASSUME_NONNULL_BEGIN

@interface SYGuessLikeCell : SYTableViewCell

@property(strong,nonatomic)PlayModel *model;

@property(copy,nonatomic)void(^collectionClick)(NSString *videoTypeID);




@end

NS_ASSUME_NONNULL_END
