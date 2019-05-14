//
//  SYEXPCollectionViewCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYEXPCollectionViewCell.h"

@implementation SYEXPCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSystem];
}
-(void)setSystem{
    _topLanel.backgroundColor = RGBA(218, 183, 112, 1);
    _bottomLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _topLanel.font = _bottomLabel.font = [UIFont systemFontOfSize:13];
}

@end

