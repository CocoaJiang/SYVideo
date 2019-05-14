//
//  CollectionReusableView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "CollectionReusableView.h"
#import "SYMoreVideos.h"
#import "SYVideoPlayerController.h"

@implementation CollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverClick)];
    _iconImageView.userInteractionEnabled=YES;
    [self.iconImageView addGestureRecognizer:zer];
    _title.font = [UIFont boldSystemFontOfSize:16];
    _morebutton.titleLabel.font = [UIFont systemFontOfSize:13];
    _name.font = [UIFont systemFontOfSize:15];
    _subName.font = [UIFont systemFontOfSize:13];
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    SYMoreVideos *videos = [[SYMoreVideos alloc]init];
    videos.title = self.model.itemName;
    videos.itemID = self.model.itemId;
    [[Tools viewController:self].navigationController pushViewController:videos animated:YES];
}

-(void)setModel:(data *)model{
    _model = model;
    [self.downBgView setHidden:NO];
    if (!model.isHaveCover) {
        [self.downBgView setHidden:YES];
    }else{
        [self.cover XJ_setImageWithURLString:model.cover.pic];
        self.name.text = model.cover.name;
        self.subName.text = [model.cover.sub_name length]>1? model.cover.sub_name:@"这条数据后台没有返回";
    }
    self.title.text  = model.itemName;
}



//图片点击
-(void)coverClick{
    
   /*
    @property(copy,nonatomic)NSString *id;
    @property(copy,nonatomic)NSString *link;
    @property(copy,nonatomic)NSString *link_type;
    @property(copy,nonatomic)NSString *name;
    @property(copy,nonatomic)NSString *pic;
    @property(copy,nonatomic)NSString *sub_name;
    */
    
    if ([self.model.cover.link_type integerValue]==0 && self.model.cover.id) {
        SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
        [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
    }
    //@"外链接 其他的外链接";
    
    
}

@end
