//
//  SYHotRankCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotRankCell.h"
#import "FindModel.h"
#import "SYVideoPlayerController.h"


@interface SYHotRankCell ()

@property(strong,nonatomic)rankModel *model;


@end

@implementation SYHotRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setSystem];
    
    
    /////
    self.showNow.clickAction = ^(UIButton *button) {
      
        SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
        
        controller.video_id = self.model.id;
        
        [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
        
    };
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setSystem{
    self.rankLabel.layer.masksToBounds=YES;
    self.rankLabel.layer.cornerRadius=2;
    self.icon.layer.cornerRadius =2;
    self.icon.layer.masksToBounds=YES;
    
    self.showNow.layer.masksToBounds = YES;
    self.showNow.layer.cornerRadius=2;
    self.showNow.layer.borderColor = KappBlue.CGColor;
    self.showNow.layer.borderWidth = 1.0f;
    [self.showNow setTitleColor:KappBlue forState:UIControlStateNormal];

}

-(void)setModelWithModel:(rankModel *)model andWithIndex:(NSInteger)index{
    
    self.model = model;
    
    switch (index) {
        case 0:
            _rankLabel.backgroundColor = [UIColor redColor];
            break;
        case 1:
            _rankLabel.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            _rankLabel.backgroundColor = RGBA(253, 196, 51, 1);
            break;
            
        default:
            _rankLabel.backgroundColor = [UIColor grayColor];
            break;
    }
    
    _rankLabel.text = [NSString stringWithFormat:@"  %@  ",model.rank];
    
    _title.text = model.name;
    
    [_icon XJ_setImageWithURLString:model.pic];
    
    _cillection.text = model.Class;
    
    _jianjie.text = model.blurb;
    
    switch ([model.trend intValue]) {
        case 0:
            _jiantou.image = [UIImage imageNamed:@"平箭头"];
            break;
        case 1:
            _jiantou.image = [UIImage imageNamed:@"上箭头"];
            break;
        case 2:
            _jiantou.image = [UIImage imageNamed:@"下箭头"];
            break;
            
        default:
            break;
    }
    
    
    
}




@end
