//
//  SYDetailCollectionViewCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYDetailCollectionViewCell : SYBaseCollectionViewCell
@property(copy,nonatomic)void(^itemClick)(NSString *value);

@end

NS_ASSUME_NONNULL_END
