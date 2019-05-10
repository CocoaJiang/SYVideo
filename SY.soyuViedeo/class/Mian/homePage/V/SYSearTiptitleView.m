//
//  SYSearTiptitleView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearTiptitleView.h"

@implementation SYSearTiptitleView

- (IBAction)buttonClick:(UIButton *)sender {
    if (self.removerAllHistory) {
        self.removerAllHistory();
    }
}


@end
