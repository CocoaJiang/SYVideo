//
//  SYPersonItemCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYPersonItemCell : SYTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *flowers;
@property (weak, nonatomic) IBOutlet UIButton *tests;
@property (weak, nonatomic) IBOutlet UIButton *gifts;
@property (weak, nonatomic) IBOutlet UIButton *addPerple;
@property(copy,nonatomic)NSString *points;



@end

NS_ASSUME_NONNULL_END
