//
//  SYLivePlayerController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLivePlayerController.h"
#import "ZFPlayer.h"
#import "ZFPlayerControlView.h"
#import "SYLiveHeaderView.h"
#import "SYlivePlayer.h"
#import "leftTableViewCell.h"
#import "PlayList.h"
#import "ZFAVPlayerManager.h"
#import <XWDatabase.h>
#import "SYSearchTVController.h"
#import "IQKeyboardManager.h"


@interface SYLivePlayerController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property(strong,nonatomic)SYLiveHeaderView *headerView;
@property(strong,nonatomic)UITableView *leftTableView;
@property(strong,nonatomic)UITableView *rightTableView;
@property(strong,nonatomic)SYlivePlayer *model;
@property(strong,nonatomic)UIButton *backButton;
@property(strong,nonatomic)NSString *url;


@end

@implementation SYLivePlayerController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    self.player.viewControllerDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden =NO;
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.player.viewControllerDisappear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self getMessage];
    [self addPlayer];
    [self savae];
}
-(void)addView{
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREEN_WIDTH*9/16);
    }];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_top).offset(40);
        }else{
            make.top.mas_equalTo(self.view.mas_top).offset(25);
        }
    }];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(@50);
        make.top.mas_equalTo(self.bgView.mas_bottom);
    }];
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.width.mas_equalTo(@60);
    }];
    [self.view addSubview:self.rightTableView];
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.view);
        make.left.mas_equalTo(self.leftTableView.mas_right);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];
}

-(void)addPlayer{
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.bgView]; //
    self.player.controlView = self.controlView;
    self.player.pauseWhenAppResignActive = NO;
        __weak typeof(self)weakSelf = self;
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        weakSelf.view.backgroundColor = isFullScreen ? [UIColor blackColor] : [UIColor whiteColor];
        [weakSelf setNeedsStatusBarAppearanceUpdate];
    };
    [self.controlView showTitle:@"" coverImage:[UIImage imageNamed:@"bg"] fullScreenMode:ZFFullScreenModeLandscape];
    self.controlView.liveController.idString = self.idString;
    self.controlView.liveController.changchnel = ^(LiveListModel * _Nonnull model) {
      //先保存信息
        weakSelf.savemodel = model;
        [weakSelf savae];
        weakSelf.idString = model.ID;
        [weakSelf getMessage];
        
    };

    NSString *URLString = [@"" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    playerManager.assetURL = [NSURL URLWithString:URLString];

}
///向服务器索要数据并建立模型。。。。。
-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [HttpTool NOACtionPOST:[SY_LivePlayer getWholeUrl] param:dict success:^(id responseObject) {
        self.model = [SYlivePlayer mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self.leftTableView reloadData];
        dayModel *getMessageCurr;
        for (dayModel *day in self.model.day) {
            if ([day.curr integerValue]==1) {
                day.isSeleted = YES;
                getMessageCurr = day;
            }
        }
        [self getRightDatawithData:getMessageCurr.date];
        self->_headerView.like.selected = [self.model.is_store boolValue];        
        [self addData_player];

    } error:^(NSString *error) {
        
    }];
    

}


-(void)addData_player{
    
    if ([self.model.routes count]>0) {
        self.model.routes[0].isSeted = YES;
        self.controlView.liveController.array_choseSetIndex = (NSMutableArray *)self.model.routes;
        
        if (!self.model.routes[0].parse) {
            ///去调用。。。。。
            NSString *URLString = [self.model.routes[0].url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            self.player.assetURL = [NSURL URLWithString:URLString];
        }else{
            NSString *address = self.model.routes[0].url;
            NSString *param =self.model.routes[0].param;
            [self getURlToPlay:param andWithAddress:address];
        }
        NSString *URLString = [self.model.routes[0].url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.url = URLString;
        self.player.assetURL = [NSURL URLWithString:URLString];

    }
   
}
////获取真正的播放地址。。。。

-(void)getURlToPlay:(NSString *)param andWithAddress:(NSString *)address{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:param forKey:@"param"];
    [HttpTool NOACtionPOST:address param:dict success:^(id responseObject) {
        NSString *string = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
        NSString *URLString = [string  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.url = URLString;
        self.player.assetURL = [NSURL URLWithString:URLString];
    } error:^(NSString *error) {
        
    }];
}







///右边数据填充
-(void)getRightDatawithData:(NSString *)data{
    [self.dataSorces removeAllObjects];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [dict setObject:data forKey:@"date"];
    [HttpTool NOACtionPOST:[SY_liveDay getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [responseObject objectForKey:@"data"]) {
            PlayList *model = [PlayList mj_objectWithKeyValues:dict];
            [self.dataSorces addObject:model];
        }
        [self.rightTableView reloadData];
    } error:^(NSString *error) {
        
    }];
}



#pragma mark -deleSources
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_leftTableView) {
        leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftTableViewCell"];
        cell.title.text = self.model.day[indexPath.row].name;
        if (self.model.day[indexPath.row].isSeleted) {
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.title.font  = [UIFont systemFontOfSize:16];
            cell.lineView.hidden  = NO;
        }else{
            cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            cell.title.font  = [UIFont systemFontOfSize:14];
            cell.lineView.hidden = YES;
        }
        return cell;
    }else{
        NSString *idstring = @"isString";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idstring];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idstring];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        PlayList *model = self.dataSorces[indexPath.row]; //0播放结束1正在播放2即将播放3已预定4无权限
        if ([model.status integerValue]==0) {
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }else if ([model.status integerValue]==1){
            cell.textLabel.textColor = KAPPMAINCOLOR;
        }else{
            cell.textLabel.textColor = [UIColor  darkTextColor];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",model.title,model.program];
        return cell;
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_leftTableView) {
        return [self.model.day count];
    }else{
        return [self.dataSorces count];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _leftTableView) {
        for (dayModel *day in self.model.day) {
            day.isSeleted = NO;
        }
        dayModel *day = self.model.day[indexPath.row];
        day.isSeleted = YES;
        [self.leftTableView reloadData];
        [self getRightDatawithData:day.date];
    }
}


///收藏
-(void)buttonClick:(UIButton *)button{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [dict setObject:@(2) forKey:@"eid"];
    [HttpTool POST:[SY_ORder getWholeUrl] param:dict success:^(id responseObject) {
        NSLog(@"%@",responseObject);
    } error:^(NSString *error) {
    }];
}

#pragma mark - lazyLout
-(SYLiveHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [Tools XJ_XibWithName:@"SYLiveHeaderView"];
        [_headerView.like addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}
-(UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 60;
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.showsHorizontalScrollIndicator = NO;
        _leftTableView.tableFooterView = [UIView new];
        [_leftTableView setHidenLine];
        [_leftTableView setOthers];
        [_leftTableView XJRegisCellWithNibWithName:@"leftTableViewCell"];
    }
    return _leftTableView;
}

-(UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 60;
        _rightTableView.showsHorizontalScrollIndicator = NO;
        _rightTableView.showsVerticalScrollIndicator = NO;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView setHidenLine];
        [_rightTableView setOthers];
    }
    return _rightTableView;
}

/*走一波思路播放都有进度条回看是能快进快退的否则是不能进行快进快退的还能走进度播放*/
#pragma mark -  播放器的控制器
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc]initWithFrame:CGRectZero andWithType:ControllerLive];
        __weak typeof(self)weakSelf = self;
        
        _controlView.landScapeControlView.forsecreen = ^{
            [weakSelf searchTVWithModel:nil andWithURL:weakSelf.url];
        };
        _controlView.portraitControlView.forScreen = ^{
            [weakSelf searchTVWithModel:nil andWithURL:weakSelf.url];
        };
    }
    return _controlView;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor blackColor];
    }
    return _bgView;
}
#pragma mark - 播放器文字相关
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}
- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}
- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

-(void)savae{
    self.savemodel.time = (long)[[Tools getCurrentTimes] integerValue];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [XWDatabase saveModel:self.savemodel completion:^(BOOL isSuccess) {
            
        }];
    });
}
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"白色右边箭头"] forState:UIControlStateNormal];
        _backButton.size  = CGSizeMake(50, 50);
        __weak typeof(self)weakSelf = self;
        _backButton.clickAction = ^(UIButton *button) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _backButton;
}

-(void)searchTVWithModel:(PlayModel *)model andWithURL:(NSString *)urlString{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SYSearchTVController *controller = [[SYSearchTVController alloc]init];
        controller.model = model;
        controller.url = urlString;
        [self.navigationController pushViewController:controller animated:YES];
    });
}

@end
