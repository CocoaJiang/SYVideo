//
//  SYDatailScrollViewItem.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/14.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYDatailScrollViewItem.h"

@implementation SYDatailScrollViewItem

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.layer.cornerRadius=2;
    self.title.layer.masksToBounds=YES;
    self.title.font = [UIFont systemFontOfSize:14];
}

-(void)settitle:(NSString *)title andSeleted:(BOOL)isseleted{
    _title.text =title;
    if (isseleted) {
        self.title.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.title.textColor = KAPPMAINCOLOR;
    }else{
        self.title.backgroundColor = [UIColor whiteColor];
        self.title.textColor = [UIColor darkGrayColor];
    }
}


@end
