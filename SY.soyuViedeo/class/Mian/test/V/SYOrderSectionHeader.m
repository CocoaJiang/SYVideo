//
//  SYOrderSectionHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/10.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYOrderSectionHeader.h"

@implementation SYOrderSectionHeader
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.text = @"用户昵称";
        [label sizeToFit];
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = label.font;
        timeLabel.text  = @"注册时间";
        [timeLabel sizeToFit];
        [self.contentView addSubview:label];
        [self.contentView addSubview:timeLabel];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(20);
            make.centerY.mas_equalTo(self.contentView.centerY);
        }];
    }
    return self;
}
@end
