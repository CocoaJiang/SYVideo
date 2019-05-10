//
//  SYHistoryItemCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYHistoryItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iCon;
@property (weak, nonatomic) IBOutlet UILabel *VideoName;
@property (weak, nonatomic) IBOutlet UILabel *progress;

@end

NS_ASSUME_NONNULL_END
