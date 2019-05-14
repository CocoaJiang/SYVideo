//
//  LiveControllerHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/24.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "LiveControllerHeader.h"

@implementation LiveControllerHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = RGBA(0, 0, 0, 0.4);
    [self.leftbutton setImage:[UIImage imageNamed:@"白色右边箭头"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"白色左边箭头"] forState:UIControlStateNormal];
    _title.font = [UIFont systemFontOfSize:14];
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    
    if (self.buttonClick) {
        if (sender==self.leftbutton) {
            self.buttonClick(@"left");
        }else{
            self.buttonClick(@"right");
        }
    }
}

@end
