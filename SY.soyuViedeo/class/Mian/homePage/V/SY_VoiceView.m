//
//  SY_VoiceView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/5/5.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SY_VoiceView.h"

@implementation SY_VoiceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        NSArray *array = @[@"+",@"音量",@"-"];
        for (int i = 0; i<[array count]; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            __weak typeof(self)weakSelf = self;
            button.clickAction = ^(UIButton *button) {
                if (weakSelf.voiceAddOrReduction) {
                    if ([button.titleLabel.text isEqualToString:@"+"]) {
                        weakSelf.voiceAddOrReduction(YES);
                    }else if([button.titleLabel.text isEqualToString:@"-"]){
                        weakSelf.voiceAddOrReduction(NO);
                    }else{
                        return ;
                    }
                }
            };
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self);
                make.height.mas_equalTo(@40);
                make.top.mas_equalTo(self.mas_top).offset(i*40);
            }];
            
        }
    }
    return self;
}
@end
