//
//  SYHotFootView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotFootView.h"
#import "SYTopDetailModel.h"
#import "SYNewLoginViewController.h"
#import "SYVideoPlayerController.h"
@implementation SYHotFootView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_collectbutton makeYuanWithScle:3 andWithToplef:YES andWithTopRight:YES andWithBootomLeft:YES andWithBootomRight:YES];
    self.backgroundColor = [UIColor clearColor];
    _title.font  = [UIFont boldSystemFontOfSize:20];
    _content.font = _doctor.font = _actor.font = _SYClass.font = _collectbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    _lookDetail.titleLabel.font = [UIFont systemFontOfSize:11];
}


-(void)setDetailModel:(videoDetail *)detailModel{
    _detailModel = detailModel;
    _title.text = detailModel.name;
    _SYClass.text  = detailModel.Class;
    _doctor.text = detailModel.director;
    _actor.text  = detailModel.actor;
    _content.text  = detailModel.blurb;
    _collectbutton.selected = [detailModel.is_store boolValue];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if ([Tools isNeedLogin]) {
        [[Tools viewController:self].navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
        return;
    }
    
    
    sender.selected = !sender.selected;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.detailModel.id forKey:@"id"];
    [dict setObject:@(1) forKey:@"mid"];
    [dict setObject:@(2) forKey:@"eid"];
    if (!sender.selected) {
        [dict setObject:@(1) forKey:@"event"];
    }else{
        [dict setObject:@(0) forKey:@"event"];
    }
    [HttpTool POST:[SY_event getWholeUrl] param:dict success:^(id responseObject) {
        
    } error:^(NSString *error) {
    }];
    
    
}
- (IBAction)player:(UIButton *)sender {
    SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
    controller.video_id = self.detailModel.id;
    [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
    
}

@end
