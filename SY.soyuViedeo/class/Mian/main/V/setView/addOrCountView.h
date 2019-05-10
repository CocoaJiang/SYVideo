//
//  addOrCountView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface addOrCountView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addCount;
@property (weak, nonatomic) IBOutlet UIButton *redution;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(copy,nonatomic)void(^addOrdetion)(NSInteger index);



@end

NS_ASSUME_NONNULL_END
