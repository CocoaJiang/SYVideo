//
//  SYNOLoginedView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYNOLoginedView.h"

@implementation SYNOLoginedView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 30;
}


- (IBAction)buttonCliick:(UIButton *)sender {
    if (self.buttonClick) {
        self.buttonClick(sender.titleLabel.text);
    }
}

@end
