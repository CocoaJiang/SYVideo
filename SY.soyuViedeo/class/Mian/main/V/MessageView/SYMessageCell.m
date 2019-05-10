//
//  SYMessageCell.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/8.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYMessageCell.h"
#import "SYTopDetailModel.h"
#import "PlayModel.h"

@implementation SYMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.icon.layer.masksToBounds=YES;
    self.icon.layer.cornerRadius=15;
    self.countent.scrollEnabled=NO;
    self.countent.userInteractionEnabled=NO;
    self.countent.showsVerticalScrollIndicator = self.countent.showsHorizontalScrollIndicator = NO;
    self.answer.hidden=self.zanButton.hidden=YES;
    [self.zanButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCellType:(MessageType )cellType{
    _cellType = cellType;
    if (cellType==0) {
        self.answer.hidden=self.zanButton.hidden=YES;
        [self.icon setHidden:YES];
        [self.titile mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_left);
        }];
        [self.time mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.icon.mas_left);
        }];
    }else if (cellType==1){
        self.answer.hidden=self.zanButton.hidden=NO;
    }else{
        self.answer.hidden=YES;
        [self.zanButton setHidden:NO];
        [_zanButton setImage:[UIImage imageNamed:@"ico_projectdetaits_comment_like_nor"] forState:UIControlStateNormal];
        [self.zanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}
-(void)buttonClick:(UIButton *)button{
    if (self.cellType==2&&button.selected) {
        return;
    }
    
    if (button==self.zanButton){
        button.selected = !button.selected;
        if (self.cellType==1) {
            self.palyerComment.yourSelfIsZan=button.selected;
        }else if (self.cellType==2){
            self.model.yourSelfIsZan  = button.selected;
        }
        if (button.selected) {
            NSString *up =  [NSString stringWithFormat:@"%ld",[self.palyerComment.up integerValue]+1];
            [_zanButton setTitle:up forState:UIControlStateSelected];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            if (self.cellType==1) {
                [dict setObject:self.palyerComment.comment_id forKey:@"commentId"];
            }else if (_cellType==2)
            {
                [dict setObject:self.model.id forKey:@"commentId"];
            }
            [HttpTool POST:[SY_zanContent getWholeUrl] param:dict success:^(id responseObject) {
                
            } error:^(NSString *error) {
                
            }];
        }else{
            [_zanButton setTitle:self.palyerComment.up forState:UIControlStateNormal];
        }
        
    }
    

}



//热门详情页模型
-(void)setModel:(commentDetail *)model{
    _model = model;
  
    [_icon XJ_setImageWithURLString:model.pic andWithImageName:[NSString stringWithFormat:@"touxiang"]];
    _titile.text =model.user_name;
    _time.text = model.time_format;
    _countent.text = model.content;
    self.zanButton.selected = model.yourSelfIsZan;
}


//播放页的评论详情
-(void)setPalyerComment:(videoPlayercomment *)palyerComment{
    _palyerComment= palyerComment;
    [_zanButton setTitle:palyerComment.up forState:UIControlStateNormal];
    self.zanButton.selected = palyerComment.yourSelfIsZan;
    [_answer setTitle:palyerComment.comment_reply forState:UIControlStateNormal];
    [_icon XJ_setImageWithURLString:palyerComment.pic];
    [_icon XJ_setImageWithURLString:palyerComment.pic andWithImageName:@"touxiang"];
    _titile.text =palyerComment.user_name;
    _time.text = palyerComment.time_format;
    _countent.text = palyerComment.content;
    
}


@end
