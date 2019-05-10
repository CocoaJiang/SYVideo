//
//  SYHotRankCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  rankModel;

NS_ASSUME_NONNULL_BEGIN

@interface SYHotRankCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *jiantou;
@property (weak, nonatomic) IBOutlet UILabel *cillection;
@property (weak, nonatomic) IBOutlet UILabel *jianjie;
@property (weak, nonatomic) IBOutlet UIButton *showNow;
@property (weak, nonatomic) IBOutlet UILabel *title;
-(void)setModelWithModel:(rankModel *)model andWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
