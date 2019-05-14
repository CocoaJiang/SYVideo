//
//  SY_ForScreen_Controller.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SY_ForScreen_Controller.h"

@implementation SY_ForScreen_Controller

-(void)awakeFromNib{
    [super awakeFromNib];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = 20;
    self.clearButton.titleLabel.font = self.exitButton.titleLabel.font = self.changDevicesButton.titleLabel.font = [UIFont systemFontOfSize:15];
}


@end
