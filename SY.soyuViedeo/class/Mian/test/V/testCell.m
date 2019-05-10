//
//  testCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/12.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "testCell.h"
#import "textModel.h"
#import "SYShareController.h"
#import "SYNewLoginViewController.h"

@implementation testCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.button setBackgroundColor:RGBA(230, 230, 230, 1) forState:UIControlStateSelected];//选中过以后
    [self.button setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];//选中过以后
    [self.button setTitleColor:RGBA(200, 200, 200, 1) forState:UIControlStateSelected];//选中后的颜色
    [self.button setTitleColor:KappBlue forState:UIControlStateNormal];
    self.button.layer.cornerRadius=30/2;
    self.button.layer.masksToBounds=YES;
    self.button.layer.borderWidth=0.4f;
    self.button.layer.borderColor = KappBlue.CGColor;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.button setTitle:@"已完成" forState:UIControlStateSelected];
    [self.button addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    [self.finshLabel setHidden:YES];
    self.finshLabel.backgroundColor = KappBlue;
    self.finshLabel.layer.masksToBounds = YES;
    self.finshLabel.layer.cornerRadius =5;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{{
    if ([keyPath isEqualToString:@"selected"]) {
        if (self.button.selected) {
            self.button.layer.borderColor = RGBA(230, 230, 230, 1).CGColor;
            self.button.userInteractionEnabled = NO;
            [self.finshLabel setHidden:NO];
        }else{
            [self.finshLabel setHidden:YES];
            self.button.userInteractionEnabled = YES;
            self.button.layer.borderColor = KappBlue.CGColor;
        }
    };
}}

-(void)dealloc{
    [self.button removeObserver:self forKeyPath:@"selected"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
 
    

}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([Tools isNeedLogin]) {
        [[Tools viewController:self].navigationController pushViewController:[SYNewLoginViewController new] animated:YES];
        return ;
    }
    
    
    if ([sender.titleLabel.text containsString:@"签到"]) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:self.model.id forKey:@"id"];
        [HttpTool POST:[SY_award getWholeUrl] param:dict success:^(id responseObject) {
            if (self.refush) {
                self.refush();
            }
        } error:^(NSString *error) {
            
        }];
    }else if ([self.title.text containsString:@"邀请"]){
        [[Tools viewController:self].navigationController pushViewController:[SYShareController new] animated:YES];
    }else if ([self.title.text containsString:@"专题"]){
        [Tools viewController:self].tabBarController.selectedIndex = 1;
    }else{
        [Tools viewController:self].tabBarController.selectedIndex = 0;
    }
}
-(void)setModel:(task_ist *)model{
    _model = model;
    _title.text = model.name;
    NSString *String = [NSString stringWithFormat:@"+%@个%@",model.points,[SYUSERINFO info].systemModel.coin_name];
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:String];
    NSTextAttachment *attchImage = [[NSTextAttachment alloc]init];
    attchImage.image =[UIImage imageNamed:@"积分金币"];
    attchImage.bounds = CGRectMake(0, 0, 12, 12);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];//位置！
    self.maflowerlabel.attributedText=attriStr;
    _dislabel.text = model.tips;
    if ([model.tips containsString:@"分享"]) {
        [self.button setTitle:@"去分享" forState:UIControlStateNormal];
    }else if ([model.tips containsString:@"观影"]){
        [self.button setTitle:@"去观看" forState:UIControlStateNormal];
    }else if ([model.tips containsString:@"广告"]){
         [self.button setTitle:@"去完成" forState:UIControlStateNormal];
    }else if ([model.tips containsString:@"邀请"]){
        [self.button setTitle:@"去完成" forState:UIControlStateNormal];
    }else if ([model.tips containsString:@"签到"]){
        [self.button setTitle:@"去签到" forState:UIControlStateNormal];
    }else{
           [self.button setTitle:@"去完成" forState:UIControlStateNormal];
    }    
    [self.icon XJ_setImageWithURLString:model.ico];
    
    if ([model.day_times integerValue]==0 && [model.today_times integerValue]==1) {
        self.button.selected = YES;
    }else if ([model.day_times integerValue]-[model.today_times integerValue]==0){
        self.button.selected = YES;
    }else{
        self.button.selected = NO;
    }
}

@end
