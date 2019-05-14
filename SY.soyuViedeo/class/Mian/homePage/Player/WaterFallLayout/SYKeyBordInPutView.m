//
//  SYKeyBordInPutView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/19.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYKeyBordInPutView.h"

@implementation SYKeyBordInPutView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.PJButton makeYuanWithScle:4];
    [self.PJButton setBackgroundColor:KAPPMAINCOLOR];
    self.textField.font = [UIFont systemFontOfSize:12];
    self.PJButton.titleLabel.font = [UIFont systemFontOfSize:12];
   self.autoresizingMask = UIViewAutoresizingNone;
    
    
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([self.textField.text length]<1) {
        [Tools showErrorWithString:@"请输入内容"];
        return;
    }
    
    if (self.pjWithContent) {
        self.pjWithContent(self.textField.text);
    }
    
    
    
}



@end
