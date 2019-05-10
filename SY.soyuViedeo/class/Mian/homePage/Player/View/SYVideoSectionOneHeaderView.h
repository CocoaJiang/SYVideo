//
//  SYVideoSectionOneHeaderView.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class videoInfo;

@interface SYVideoSectionOneHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *tipLanel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *inducebutton;
@property (weak, nonatomic) IBOutlet UILabel *playtimes;
@property (weak, nonatomic) IBOutlet UILabel *CollectionsLabl;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *feedBackButton;
@property (weak, nonatomic) IBOutlet UILabel *comments;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property(copy,nonatomic)void(^buttonClick)(NSString *titleLabel);
@property(strong,nonatomic)videoInfo *info;
@property (weak, nonatomic) IBOutlet UIButton *choseButton;
@property (weak, nonatomic) IBOutlet UIImageView *palyIcon;
@property (weak, nonatomic) IBOutlet UIImageView *downjiantou;
@property(assign,nonatomic)NSInteger choseIndex;


@end

NS_ASSUME_NONNULL_END
