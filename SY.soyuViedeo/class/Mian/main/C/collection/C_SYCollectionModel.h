//
//  C_SYCollectionModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface C_itemModel:NSObject

@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *remark;
@property(assign,nonatomic)BOOL isseleted;


@end

@interface C_SYCollectionModel : NSObject
@property(copy,nonatomic)NSString *type_id;
@property(copy,nonatomic)NSString *type_name;
@property(strong,nonatomic)NSMutableArray <C_itemModel*>*data;

@end




NS_ASSUME_NONNULL_END
