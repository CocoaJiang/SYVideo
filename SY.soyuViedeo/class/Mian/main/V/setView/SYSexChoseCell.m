//
//  SYSexChoseCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYSexChoseCell.h"

@implementation SYSexChoseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.selected) {
        if (self.sexChose) {
            self.sexChose(self.boysButton.selected?@"男":@"女");
        }
        return;
    }
    sender.selected  = !sender.selected;
    if (sender==self.girlButton) {
        if (sender.selected) {
            self.boysButton.selected = NO;
        }
    }else{
        self.girlButton.selected=NO;
    }
    
    if (self.sexChose) {
        self.sexChose(self.boysButton.selected?@"男":@"女");
    }
    

}


@end
