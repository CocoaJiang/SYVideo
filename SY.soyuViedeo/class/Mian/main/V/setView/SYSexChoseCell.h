//
//  SYSexChoseCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYSexChoseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *girlButton;
@property (weak, nonatomic) IBOutlet UIButton *boysButton;
@property(copy,nonatomic)void(^sexChose)(NSString *sex);



@end

NS_ASSUME_NONNULL_END
