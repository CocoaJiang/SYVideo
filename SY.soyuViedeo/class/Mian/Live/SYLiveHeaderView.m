 //
//  SYLiveHeaderView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveHeaderView.h"

@implementation SYLiveHeaderView

- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.title.font = [UIFont systemFontOfSize:14];
}


@end
