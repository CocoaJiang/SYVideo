//
//  SYKeywordsController.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYKeywordsController : SYBaseViewController
@property(strong,nonatomic)NSMutableArray *keywordsArray;
@property(strong,nonatomic)NSString *keyWordString;
@property(copy,nonatomic)void(^searchClick)(NSString *searchKeyWords);
-(void)upKeyWordsWithText:(NSString *)text;



@end

NS_ASSUME_NONNULL_END
