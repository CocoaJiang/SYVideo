//
//  PersonHeaderCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/6.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *jiantouImage;

@end

NS_ASSUME_NONNULL_END
