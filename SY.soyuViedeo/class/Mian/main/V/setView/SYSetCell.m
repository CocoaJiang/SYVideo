//
//  SYSetCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019年 搜云. All rights reserved.
//

#import "SYSetCell.h"

@implementation SYSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.jiantou setHidden:YES];
    [self.SYswitch setHidden:YES];
    [self.text setHidden:YES];
    [self.redPoint setHidden:YES];
    [self.SYswitch setOnTintColor:KappBlue];
    [self.SYswitch addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setType:(SetCllType)type{
    if (type==CellTpyeJiantou) {
        [self.jiantou setHidden:NO];
        [self.SYswitch setHidden:YES];
        [self.text setHidden:YES];
        [self.redPoint setHidden:YES];

    }else if (type==CellTypeSwitch){
        [self.jiantou setHidden:YES];
        [self.SYswitch setHidden:NO];
        [self.text setHidden:YES];
        [self.redPoint setHidden:YES];

    }else if(type==CellTypeText){
        [self.jiantou setHidden:YES];
        [self.SYswitch setHidden:YES];
        [self.text setHidden:NO];
        [self.redPoint setHidden:YES];
    }else if (type==CellTypeMessage){
        [self.jiantou setHidden:NO];
        [self.SYswitch setHidden:YES];
        [self.text setHidden:YES];
        [self.redPoint setHidden:NO];
    }
    else{
        self.text.font = [UIFont systemFontOfSize:12];
        [self.jiantou setHidden:NO];
        [self.SYswitch setHidden:YES];
        [self.text setHidden:NO];
        [self.text mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-30);
        }];
        
    }
}

-(void)change:(UISwitch *)swi{
    if (self.SwitchBlock) {
        self.SwitchBlock(self.title.text, swi.isOn);
        
    }
}



@end
