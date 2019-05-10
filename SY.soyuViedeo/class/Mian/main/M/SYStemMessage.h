//
//  SYStemMessage.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYStemMessage : NSObject
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *message_time;
@property(assign,nonatomic)CGFloat   cellHeight;
@end

NS_ASSUME_NONNULL_END
