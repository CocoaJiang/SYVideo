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
    self.contentView.layer.cornerRadius=2;
    self.contentView.layer.masksToBounds=YES;
}

-(void)settitle:(NSString *)title andSeleted:(BOOL)isseleted{
    _title.text =title;
    if (isseleted) {
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.title.textColor = KappBlue;
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.title.textColor = [UIColor darkGrayColor];
    }
}


@end
