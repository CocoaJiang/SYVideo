//
//  LSNewContentTableViewCell.m
//  乐氏同仁APP
//
//  Created by Mac on 2018/11/7.
//  Copyright © 2018 双木科技张晓红. All rights reserved.
//

#import "LSNewContentTableViewCell.h"
#import "UITextView+YLTextView.h"


@implementation LSNewContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.placeholder = @"请输入反馈内容";
    self.textView.limitLength = @(1800);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
