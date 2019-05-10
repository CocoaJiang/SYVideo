//
//  UIButton+button_Rect.m
//  直播购物APP
//
//  Created by seekmac002 on 2018/7/27.
//  Copyright © 2018年 buySomthing. All rights reserved.
//

#import "UIButton+button_Rect.h"
static char *const kAction = "kAction";
@implementation UIButton (button_Rect)
- (void)setUpImageAndDownLableWithSpace:(CGFloat)space{
    
        CGSize imageSize = self.imageView.frame.size;
        CGSize titleSize = self.titleLabel.frame.size;
    
        // titleLabel的宽度不一定正确的时候，需要进行判断
        CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
        if (titleSize.width < labelWidth) {
                titleSize.width = labelWidth;
            }
    
        // 文字距上边框的距离增加imageView的高度+间距，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height+space, -imageSize.width, -space, 0.0)];
    
        // 图片距右边框的距离减少图片的宽度，距离上面的间隔，其它不变
        [self setImageEdgeInsets:UIEdgeInsetsMake(-space, 0.0,0.0,-titleSize.width)];
    }

/**
  + 左边是文字，右边是图片（和原来的样式翻过来）
  +
  + @param space 间距
  + */
- (void)setLeftTitleAndRightImageWithSpace:(CGFloat)space{
   
       CGSize imageSize = self.imageView.frame.size;
       CGSize titleSize = self.titleLabel.frame.size;
    
       // titleLabel的宽度不一定正确的时候，需要进行判断
       CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
       if (titleSize.width < labelWidth) {
                titleSize.width = labelWidth;
           }
    
    
     [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width)];
     [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width-space, 0.0, imageSize.width)];
    

   }

/**
  + 设置角标的个数（右上角）
  +
  + @param badgeValue <#badgeValue description#>
  + */
- (void)setBadgeValue:(NSInteger)badgeValue{
    
        CGFloat badgeW   = 20;
        CGSize imageSize = self.imageView.frame.size;
        CGFloat imageX   = self.imageView.frame.origin.x;
        CGFloat imageY   = self.imageView.frame.origin.y;
    
        UILabel *badgeLable = [[UILabel alloc]init];
    
    
    if (badgeValue > 99) {
        
        badgeLable.text = @"99+";
    }else{
        
    badgeLable.text = [NSString stringWithFormat:@"%ld",badgeValue];
        
    }
    
    

        badgeLable.textAlignment = NSTextAlignmentCenter;
        badgeLable.textColor = [UIColor whiteColor];
        badgeLable.font = [UIFont systemFontOfSize:10];
        badgeLable.layer.cornerRadius = badgeW*0.5;
        badgeLable.clipsToBounds = YES;
        badgeLable.backgroundColor = [UIColor redColor];
   
      CGFloat badgeX = imageX + imageSize.width - badgeW*0.3;
    
    
      CGFloat badgeY = imageY - badgeW*0.5;
    
      badgeLable.frame = CGRectMake(badgeX, badgeY, badgeW, badgeW);
    
    
    if (badgeValue==0) {
        
        [badgeLable setHidden:YES];
    }
    
     [self addSubview:badgeLable];
}

-(void)makeYuanWithScle:(CGFloat)scle{
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(scle, scle)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
}
-(void)makeYuanWithScle:(CGFloat)scle andWithToplef:(BOOL)topLeft andWithTopRight:(BOOL)topRight andWithBootomLeft:(BOOL)bootomLeft andWithBootomRight:(BOOL)bootomRight{
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(scle, scle)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
}



- (void)setClickAction:(void (^)(UIButton *))clickAction
{
    objc_setAssociatedObject(self, kAction, clickAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [self removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (clickAction) {
        
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void (^)(UIButton *))clickAction
{
    return objc_getAssociatedObject(self, kAction);
}

- (void)buttonClick:(UIButton *)button
{
    if (self.clickAction) {
        self.clickAction(button);
    }
}




@end
