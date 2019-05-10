//
//  BootomDelegateView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BootomDelegateView : UIView
@property (weak, nonatomic) IBOutlet UIButton *choseAll;
@property (weak, nonatomic) IBOutlet UIButton *delegateAll;
-(void)setCountWithIndex:(NSInteger)count;
@property(copy,nonatomic)void(^buttonClick)(NSString *title);


@end

NS_ASSUME_NONNULL_END
