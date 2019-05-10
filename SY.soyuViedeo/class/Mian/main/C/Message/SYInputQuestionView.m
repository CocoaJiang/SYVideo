//
//  SYInputQuestionView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/17.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYInputQuestionView.h"
#import "UITextView+YLTextView.h"
@implementation SYInputQuestionView
-(void)awakeFromNib{
    [super awakeFromNib];
    self.textView.placeholder = @"请描述下您出现问题的详细场景,时间点,便于我们更好的为您解决问题!";
}

@end
