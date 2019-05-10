//
//  NSString+Seleted.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/26.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Seleted)
///是否选中
- (BOOL )isSeleted;

-(void)setIsSeleted:(BOOL)isSeleted;

@end

NS_ASSUME_NONNULL_END
