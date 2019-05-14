//
//  SYCoin_log.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/16.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCoin_log.h"
#import "SYCoinLogsModel.h"
@implementation SYCoin_log

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _titleLanel.font = [UIFont systemFontOfSize:14];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _coinLabel.font  = [UIFont systemFontOfSize:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setModel:(SYCoinLogsModel *)model{
    _model = model;
    _titleLanel.text  = model.info;
    _timeLabel.text = model.date_time;
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"littleGold"];
    attachment.bounds = CGRectMake(0, 0, 12, 12);
    NSMutableAttributedString *attriedString = (NSMutableAttributedString *)[Tools ReturnWithString:model.points andWithColor:[UIColor orangeColor] andWithFont:13 andWithString:@" " andWithColor:[UIColor whiteColor] andWithFont:22];
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attachment];
    [attriedString insertAttributedString:stringImage atIndex:attriedString.length];
    _coinLabel.attributedText = attriedString;
    
}

@end
