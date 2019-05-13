//
//  SYSearchResultCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/25.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchResultCell.h"
#import "HomePageModel.h"

@implementation SYSearchResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.score.layer.cornerRadius=2;
    self.score.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(item *)model{
    _model = model;
    _time.text = model.remark;
    _score.text  = [NSString stringWithFormat:@"  豆瓣  %@  ",model.douban_score];
    [_icon XJ_setImageWithURLString:model.pic];
    _title.text = model.name;
    _playtimes.text = [NSString stringWithFormat:@"播放:%@",model.hits];
    switch ([model.hot integerValue]) {
        case 0:
            [self.cleanFloat setHidden:YES];
            break;
        case 1:
            self.cleanFloat.image = [UIImage imageNamed:@"火爆"];
            break;
        case 2:
            self.cleanFloat.image = [UIImage imageNamed:@"hot_ma"];
            break;
            
        default:
            self.cleanFloat.image = [UIImage imageNamed:@"1080P_ma"];
            break;
    }
    
    NSString *orangString = model.name;
    //先找到关键字的位置
    NSRange range = [orangString rangeOfString:self.model.keyWords];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:orangString];
    //添加高亮为红色
    [attribute addAttribute:NSForegroundColorAttributeName value:KAPPMAINCOLOR range:range];
    _title.attributedText = attribute;
    
    
}


@end
