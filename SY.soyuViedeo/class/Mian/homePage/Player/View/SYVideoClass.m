//
//  SYVideoClass.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoClass.h"
#import "SYChoseEpisodCell.h"
#import "DCCollectionHeaderLayout.h"
#import "UILabel+HuaZhi.h"


@interface SYVideoClass ()<HorizontalCollectionLayoutDelegate>
@property(strong,nonatomic)UIButton *buttonOpen;
@property(strong,nonatomic)UIView *tagContentView;
@property(assign,nonatomic)CGFloat historyHight;

@end

@implementation SYVideoClass

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.buttonOpen];
        [self.contentView addSubview:self.tagContentView];
        [self.buttonOpen addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
       
    }
    return self;
}

//监听旋转部分。。。。。
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selected"]) {
        if (self.buttonOpen.selected) {
            [UIView animateWithDuration:0.3 animations:^{
                if (self.buttonOpen.imageView) {
                    self.buttonOpen.transform = CGAffineTransformMakeRotation(M_PI/2);
                }
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                if (self.buttonOpen.imageView) {
                    self.buttonOpen.transform = CGAffineTransformIdentity;
                }
            }];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.buttonOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(@0.4);
    }];
    [self.tagContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.lineView.mas_top);
        make.right.mas_equalTo(self.buttonOpen.mas_left).offset(-10);
    }];
}

-(UIButton *)buttonOpen{
    if (!_buttonOpen) {
        _buttonOpen = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonOpen setImage:[UIImage imageNamed:@"右箭头"] forState:UIControlStateNormal];
        [_buttonOpen addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
        _buttonOpen.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    }
    return _buttonOpen;
}
-(void)cancelButton:(UIButton *)button{
    button.selected = !button.selected;
    if (self.sendHeight) {
        self.sendHeight(button.selected?self.historyHight-60:0);
    }
}
-(UIView *)tagContentView{
    if (!_tagContentView) {
        _tagContentView = [[UIView alloc]init];
        _tagContentView.clipsToBounds=YES;
    }
    return _tagContentView;
}
- (void)updateHistoryList {
    for (UIView *view in self.tagContentView.subviews) {
        if (view.tag == 1999) {
            [view removeFromSuperview];
        }
    }
    CGSize orgxy=CGSizeMake(10, 20);
    for (int i=0; i<self.dataArray.count; i++) {
        UILabel *historyLabel=[[UILabel alloc] init];
        historyLabel.backgroundColor = RGBA(244, 244, 244, 1);
        historyLabel.clipsToBounds = YES;
        historyLabel.layer.cornerRadius = 3;
        historyLabel.tag = 1999;
        historyLabel.font = [UIFont systemFontOfSize:15];
        historyLabel.textColor = RGBA(51, 51, 51, 1);
        historyLabel.text=[NSString stringWithFormat:@"  %@  ", self.dataArray[i]];
        orgxy=[historyLabel XJNextOrgin:orgxy];
        historyLabel.userInteractionEnabled=YES;
        [self.tagContentView addSubview:historyLabel];
        self.historyHight = orgxy.height+40;
    }
}

-(void)setLabelArray:(NSMutableArray *)labelArray{
    _labelArray = labelArray;
    self.dataArray = labelArray;
    [self updateHistoryList];
}


@end
