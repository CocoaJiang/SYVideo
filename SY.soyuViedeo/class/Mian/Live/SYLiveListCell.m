//
//  SYLiveListCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveListCell.h"
#import "SYCollectionModel.h"
#import "LiveListModel.h"


@interface SYLiveListCell()<UIGestureRecognizerDelegate>

@end

@implementation SYLiveListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius  = 5;
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.deleteButton.hidden = YES;
    self.title.font = [UIFont systemFontOfSize:15];
    self.subTitle.font = [UIFont systemFontOfSize:12];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(SYCollectionModel *)model{
    _model = model;
    [self.icon XJ_setImageWithURLString:model.thumb];
    self.title.text  = model.name;
    self.subTitle.text  = model.program;
}

-(void)setLiveModel:(LiveListModel *)liveModel{
    _liveModel = liveModel;
    [self.icon XJ_setImageWithURLString:liveModel.pic];
    self.title.text  = liveModel.name;
    self.subTitle.text  = liveModel.program;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (!self.isChangFreme) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.frame = CGRectMake(-100, 0, self.contentView.width, self.contentView.height);
        }completion:^(BOOL finished) {
            self.isChangFreme=YES;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
        }completion:^(BOOL finished) {
            self.isChangFreme=NO;
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.isChangFreme) {
        return YES;
    }
    if (!self.isChangFreme) {
        return NO;
    }
    return YES;
}


-(void)cellClick{
   
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    }completion:^(BOOL finished) {
        self.isChangFreme=NO;
    }];
    
}

-(void)setType:(isShowType)type{
    _type = type;
    if (self.type==HIDEN) {
        self.deleteButton.hidden = YES;
    }else{
        self.deleteButton.hidden = NO;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellClick)];
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addGestureRecognizer:zer];
        zer.delegate = self;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:KAPPMAINCOLOR];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDelete) forControlEvents:UIControlEventTouchUpInside];
        self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH+100, self.contentView.height);
        button.frame = CGRectMake(SCREEN_WIDTH, self.contentView.top, 100, self.contentView.height);
        [self.contentView addSubview:button];
    }
}
-(void)buttonDelete{
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height);
    }completion:^(BOOL finished) {
        self.isChangFreme=NO;
    }];
    if (self.canEdit) {
        self.canEdit();
    }
 
    
}




@end
