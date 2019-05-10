//
//  SYCellTitleView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYCellTitleView.h"

@implementation SYCellTitleView

- (IBAction)rightLabelClick:(UIButton *)sender {
    if (self.rightClick) {
        self.rightClick();
    }
}

@end
