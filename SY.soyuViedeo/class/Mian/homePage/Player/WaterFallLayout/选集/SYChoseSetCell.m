//
//  SYChoseSetCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/2.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYChoseSetCell.h"
#import "NSString+Seleted.h"

@implementation SYChoseSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setType:(choseCellType)type{
    _type = type;
    if (type==1) {
     self.contentView.layer.borderWidth=CGFLOAT_MIN;
    }else{
        self.contentView.layer.borderWidth = 0.4f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

-(void)setText:(NSString *)text{
    _text = text;
    if (text.isSeleted) {
        if (self.type==hasBorldColor) {
             self.contentView.layer.borderColor = KAPPMAINCOLOR.CGColor;
        }
        self.title.textColor = KAPPMAINCOLOR;
        self.title.text = text;
    }else{
        if (self.type==hasBorldColor) {
            self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        self.title.textColor = [UIColor whiteColor];
        self.title.text = text;
    }
}


@end
