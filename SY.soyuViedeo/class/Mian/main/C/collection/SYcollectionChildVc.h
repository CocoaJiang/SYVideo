//
//  SYcollectionChildVc.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"
@class C_SYCollectionModel;

NS_ASSUME_NONNULL_BEGIN

@interface SYcollectionChildVc : SYBaseViewController
@property(strong,nonatomic)C_SYCollectionModel *model;
@property(assign,nonatomic)BOOL tableViewEditing;
@property(copy,nonatomic)dispatch_block_t cancel;


@end

NS_ASSUME_NONNULL_END
