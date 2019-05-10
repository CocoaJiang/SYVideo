//
//  SYSearchDevicesCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYSearchDevicesCell : UITableViewCell
@property(strong,nonatomic)NSMutableArray *array;
@property(copy,nonatomic)void(^choseCell)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
