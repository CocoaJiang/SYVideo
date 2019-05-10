//
//  SYHotSearchCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYSearchModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SYHotSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;
@property (weak, nonatomic) IBOutlet UIImageView *hotIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *upOrDownicon;
@property(strong,nonatomic)searchDetailModel *searchDetailModel;


@end

NS_ASSUME_NONNULL_END
