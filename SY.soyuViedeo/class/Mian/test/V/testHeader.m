//
//  testHeader.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "testHeader.h"

@implementation testHeader

-(void)awakeFromNib{
    [super awakeFromNib];
    [self makeButtonToBeautiful:self.invitation];
    [self makeButtonToBeautiful:self.exchange];
    self.today.attributedText = [Tools ReturnWithString:@"今日" andWithColor:[UIColor lightGrayColor] andWithFont:13 andWithString:[self.today.text substringFromIndex:2] andWithColor:RGBA(255, 210, 54, 1) andWithFont:13];
}
-(void)makeButtonToBeautiful:(UIButton *)button{
    button.layer.cornerRadius=10;
    button.layer.masksToBounds=YES;
    button.layer.borderColor = KappBlue.CGColor;
    button.layer.borderWidth =0.4f;
}



@end
