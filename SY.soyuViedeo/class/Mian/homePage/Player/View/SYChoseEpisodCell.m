//
//  SYChoseEpisodCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChoseEpisodCell.h"

@implementation SYChoseEpisodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.number.layer.cornerRadius=2;
    self.number.layer.masksToBounds=YES;
}
-(void)setIsOnWathch:(BOOL)isOnWathch{
    _isOnWathch = isOnWathch;
    if (isOnWathch) {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.3f;
        self.number.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
}
@end
