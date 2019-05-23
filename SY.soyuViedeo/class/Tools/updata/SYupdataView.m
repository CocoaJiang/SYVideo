//
//  SYupdataView.m
//  SY.souyunVideo
//
//  Created by 搜云 on 2019/5/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYupdataView.h"

@interface SYupdataView ()

@end


@implementation SYupdataView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cancelButton.titleLabel.font = self.sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.textField.userInteractionEnabled = NO;
    self.textField.scrollEnabled = NO;
    self.textField.font = [UIFont systemFontOfSize:16];
    self.textField.textColor = [UIColor lightGrayColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = 10;
    
}


@end

