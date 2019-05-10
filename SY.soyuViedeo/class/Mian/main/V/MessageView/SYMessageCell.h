//
//  SYMessageCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MessageType){
    MessageCell=0,
    PJVideo=1,
    PJHotCell=2,
};
@class commentDetail;

@class videoPlayercomment; //播放页面的评论………………

NS_ASSUME_NONNULL_BEGIN
@interface SYMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titile;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextView *countent;
@property (weak, nonatomic) IBOutlet UIButton *answer;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property(assign,nonatomic)MessageType cellType;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property(strong,nonatomic)commentDetail *model;
@property(strong,nonatomic)videoPlayercomment *palyerComment;





@end

NS_ASSUME_NONNULL_END
