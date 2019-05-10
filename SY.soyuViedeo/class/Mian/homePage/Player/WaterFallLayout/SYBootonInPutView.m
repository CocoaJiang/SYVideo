//
//  SYBootonInPutView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYBootonInPutView.h"

@interface SYBootonInPutView ()

@property(strong,nonatomic)UIButton *loadButton; //下载按钮

@property(strong,nonatomic)UIButton *collectionButton; //收藏按钮

@property(strong,nonatomic)UIView *bgView; //背景图

@property(strong,nonatomic)UIImageView *imageView; //前面的小图标

@property(strong,nonatomic)UIView *lineView; //顶部的那根线

@property(strong,nonatomic)UILabel *placeLabel;

@end


@implementation SYBootonInPutView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.loadButton];
        [self addSubview:self.collectionButton];
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.imageView];
        [self addSubview:self.lineView];
        [self.bgView addSubview:self.placeLabel];
        
        [self.loadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(38, 38));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.loadButton.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(38, 38));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.collectionButton.mas_left).offset(-10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.height.mas_equalTo(@35);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
        }];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bgView.mas_centerY);
            make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        }];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(@0.4);
        }];
        [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).offset(20);
            make.centerY.mas_equalTo(self.bgView.mas_centerY);
        }];
    }
    return self;
}

//从左往右 依次进行！！！

-(UIButton *)loadButton{
    if (!_loadButton) {
        _loadButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_loadButton setImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
        [_loadButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loadButton;
}


-(UIButton *)collectionButton{
    if (!_collectionButton) {
        _collectionButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionButton setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"收藏_选中"] forState:UIControlStateSelected];
        [_collectionButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectZero];
        _bgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        _bgView.layer.borderWidth = 0.3f;
        _bgView.layer.masksToBounds=YES;
        _bgView.layer.cornerRadius=3;
        _bgView.userInteractionEnabled=YES;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClick)];
        [_bgView addGestureRecognizer:zer];
    }
    return _bgView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_video_commentLight"]];
        [_imageView sizeToFit];
    }
    return _imageView;
}

-(void)setType:(bootomType)type{
    _type = type;
    if (type==1) {
        self.loadButton.hidden = self.collectionButton.hidden = YES;
        [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.height.mas_equalTo(@35);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-2);
        }];
        _bgView.layer.cornerRadius = 10;
        _placeLabel.textColor = [UIColor whiteColor];
        _placeLabel.text = @"发表点我的感想吧";
    }

}

//开始布局


-(void)buttonClick:(UIButton *)button{
    if (button==self.loadButton) {
        if (self.buttonClick) {
              self.buttonClick(@"下载");
        }
    }else{
         button.selected = !button.selected;
        [self zanORCancel:button.selected];
    }
    
    
}
-(void)viewClick{
    if (self.buttonClick) {
        self.buttonClick(@"弹出键盘");
    }
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineView;
}

-(UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]init];
        _placeLabel.textColor = [UIColor darkGrayColor];
        _placeLabel.text = @"写下您的感想吧~";
        _placeLabel.font = [UIFont systemFontOfSize:12];
        [_placeLabel sizeToFit];
    }
    return _placeLabel;
}
-(void)setStore:(NSString *)store{
    _store = store;
    _collectionButton.selected = [store boolValue];
}



-(void) zanORCancel:(BOOL)zanOrCancel{
    
     NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
     [dict setObject:self.videoID forKey:@"id"];
     [dict setObject:@(1) forKey:@"mid"];
     [dict setObject:@(2) forKey:@"eid"];
    if (zanOrCancel) {
        [dict setObject:@(1) forKey:@"event"];
    }else{
        [dict setObject:@(0) forKey:@"event"];
    }
    [HttpTool POST:[SY_event getWholeUrl] param:dict success:^(id responseObject) {
    } error:^(NSString *error) {
    }];
}


@end
