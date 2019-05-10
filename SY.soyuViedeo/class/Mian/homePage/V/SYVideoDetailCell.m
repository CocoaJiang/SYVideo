//
//  SYVideoDetailCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/7.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYVideoDetailCell.h"

@implementation SYVideoDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(item *)model{
    _model = model;
    [self.hotimageView setHidden:NO];
    switch ([model.hot integerValue]) {
        case 0:
            [self.hotimageView setHidden:YES];
            break;
        case 1:
            self.hotimageView.image = [UIImage imageNamed:@"ico_filmlist_filmlabel_hot"];
            break;
        case 2:
            self.hotimageView.image = [UIImage imageNamed:@"hot_ma"];
            break;
            
        default:
            self.hotimageView.image = [UIImage imageNamed:@"1080P_ma"];
            break;
    }
    [self.icon XJ_setImageWithURLString:model.pic];
    self.title.text= model.name;
    self.dislabel.text = model.sub_name?:@"这个字段后台没有返回";
    self.contentLanel.text = model.remark;
    
    
    
}

@end
