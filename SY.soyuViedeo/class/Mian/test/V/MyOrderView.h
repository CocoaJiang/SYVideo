//
//  MyOrderView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/10.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *person;

@end

NS_ASSUME_NONNULL_END
