//
//  BootomDelegateView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "BootomDelegateView.h"

@implementation BootomDelegateView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.delegateAll.titleLabel.alpha=0.4;
    self.delegateAll.userInteractionEnabled = NO;
    self.choseAll.titleLabel.font = self.delegateAll.titleLabel.font = [UIFont systemFontOfSize:13];
}
-(void)setCountWithIndex:(NSInteger)count{
    if (count==0) {
        self.delegateAll.titleLabel.alpha = 0.4;
        self.delegateAll.userInteractionEnabled = NO;
        [self.delegateAll setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        self.delegateAll.titleLabel.alpha = 1;
        self.delegateAll.userInteractionEnabled = YES;
        [self.delegateAll setTitle:[NSString stringWithFormat:@"删除(%ld)",count] forState:UIControlStateNormal];
    }
}
- (IBAction)deleteORChoseAll:(UIButton *)sender {
    if (sender==self.choseAll) {
        sender.selected = !sender.selected;
    }
    if (self.buttonClick) {
        self.buttonClick(sender.titleLabel.text);
    }
}

@end
