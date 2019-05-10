//
//  SYEditHeaderItem.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/7.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYEditHeaderItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *seletedImageView;

@end

NS_ASSUME_NONNULL_END
