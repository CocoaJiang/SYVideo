//
//  SYHomePagefootView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHomePagefootView.h"
#import "SYMoreVideos.h"

@implementation SYHomePagefootView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.lookMore makeYuanWithScle:5];
    self.lookMore.layer.cornerRadius = 5;
    self.lookMore.layer.masksToBounds = YES;
    self.Change.layer.masksToBounds =  YES;
    self.Change.layer.cornerRadius = 5;
    [self.lookMore setLeftTitleAndRightImageWithSpace:5];
    [self.Change setLeftTitleAndRightImageWithSpace:6];
    self.lookMore.titleLabel.font = self.Change.titleLabel.font = [UIFont systemFontOfSize:12];
}
-(void)setData:(data *)data{
    _data = data;
    [self.downView setHidden:NO];
    if (data.isHaveAdd) {
        [self.addImage XJ_setImageWithURLString:data.ad.pic];
    }else{
        [self.downView setHidden:YES];
    }
}
- (IBAction)lookMore:(UIButton *)sender {
    SYMoreVideos *videos = [[SYMoreVideos alloc]init];
    videos.title = self.data.itemName;
    videos.itemID = self.data.itemId;
    [[Tools viewController:self].navigationController pushViewController:videos animated:YES];
}
- (IBAction)change:(UIButton *)sender {
    //在Cell里写请求 完成后通知CollectionView 去刷新。。。。我觉得这个设计模式很可以、,间接的削弱VC的能力 可更好的拆分、、并将数据替换！!!!!!!!
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setObject:self.type_id forKey:@"id"];
    [dictionary setObject:@(6) forKey:@"pageSize"];
    [HttpTool POST:[SY_Change getWholeUrl] param:dictionary success:^(id responseObject) {
        if (self.refush) {
            //去通知刷新。。。。。
            self.refush();
        }
    } error:^(NSString *error) {

    }];
}
@end
