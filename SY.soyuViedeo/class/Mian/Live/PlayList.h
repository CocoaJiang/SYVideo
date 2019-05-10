//
//  PlayList.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayList : NSObject

@property(copy,nonatomic)NSString *date;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *program;
@property(copy,nonatomic)NSString *status;
@end

NS_ASSUME_NONNULL_END
