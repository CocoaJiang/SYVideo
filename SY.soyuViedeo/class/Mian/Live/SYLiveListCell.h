//
//  SYLiveListCell.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYTableViewCell.h"
@class SYCollectionModel;
@class LiveListModel;
typedef NS_ENUM(NSInteger,isShowType){
    HIDEN=0,
    ISSHOW=1,
};


NS_ASSUME_NONNULL_BEGIN

@interface SYLiveListCell : SYTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property(strong,nonatomic)SYCollectionModel *model;
@property(copy,nonatomic)dispatch_block_t canEdit;
@property(assign,nonatomic)BOOL isChangFreme;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property(assign,nonatomic)isShowType type;
@property(strong,nonatomic)LiveListModel *liveModel;


@end

NS_ASSUME_NONNULL_END
