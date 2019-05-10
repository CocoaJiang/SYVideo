//
//  SYCollectionModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCollectionModel : NSObject
/*
 "id": 1,
 "pic": "http://192.168.10.192/upload/ad/20190410-1/ed64e5765e337f567b0a726191dc0696.gif",
 "thumb": "http://192.168.10.192/upload/ad/20190410-1/044452c7c44fa5cf960a595255603f6b.JPG",
 "name": "央视综合",
 "program": "暂无节目"
 */
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *thumb;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *program;
@property(copy,nonatomic)NSString *eid;
@end

NS_ASSUME_NONNULL_END
