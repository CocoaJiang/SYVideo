//
//  SYHotPlayerCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotPlayerCell.h"

@implementation SYHotPlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //添加毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectView.frame = CGRectMake(10, 5, SCREEN_WIDTH-20, 40);
    [effectView makeYuanWithScle:20 andWithToplef:YES andWithTopRight:YES andWithBootomLeft:YES andWithBootomRight:YES];
    [self.contentView insertSubview:effectView atIndex:0];
    //把控件添加在子试图上！！！！
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
  
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
