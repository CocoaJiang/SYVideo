//
//  SYhotViedeCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/15.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYhotViedeCell.h"
#import "SYShareObject.h"

@implementation SYhotViedeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.giveaLiker.hidden = self.leveMessage.hidden =YES;
    __weak typeof(self)weakSelf = self;
    self.share.clickAction = ^(UIButton *button) {
        [SYShareObject shareWithController:[Tools viewController:weakSelf] andWithImage:nil andWithUrl:[SYUSERINFO info].systemModel.shareURL andWithArray:SHAREARRAY andBlock:nil];
    };
    _title.font = [UIFont systemFontOfSize:15];
    _time.font = [UIFont systemFontOfSize:13];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius =  5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setModel:(hotModel *)model{
    _model = model;
    _time.text = model.time_format;
    [_icon XJ_setImageWithURLString:model.pic];
    _title.text = model.title;
}

@end
