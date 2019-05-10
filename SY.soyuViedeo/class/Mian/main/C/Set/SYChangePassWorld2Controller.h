//
//  SYChangePassWorld2Controller.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBaseViewController.h"

typedef NS_ENUM(NSInteger,SafeController){
    changPaassWord=0,
    changPhone=1,
    yanzheng=2,
};

NS_ASSUME_NONNULL_BEGIN

@interface SYChangePassWorld2Controller : SYBaseViewController
@property(assign,nonatomic)SafeController type;
@property(strong,nonatomic)NSString *phone;



@end

NS_ASSUME_NONNULL_END
