//
//  SYVideoPlayerController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/18.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoPlayerController.h"
#import "ZFPlayer.h"
#import "ZFAVPlayerManager.h"
#import "KSMediaPlayerManager.h"
#import "ZFPlayerControlView.h"
#import "ZFIJKPlayerManager.h"
#import "UIView+ZFFrame.h"
#import "SYVideoSectionOneHeaderView.h"
#import "SYVideoPlayerCell.h"
#import "SYVideoClass.h"
#import "SYTableViewHeader.h"
#import "SYGuessLikeCell.h"
#import "SYMessageCell.h"
#import "SYBootonInPutView.h"
#import "SYKeyBordInPutView.h"
#import "IQKeyboardManager.h"
#import "SYIntroductionView.h"
#import "PlayModel.h"
#import "HomePageModel.h"
#import "ZXJPopView.h"
#import "SYHotPJTHeader.h"
#import <WebKit/WebKit.h>
#import "SYVideoPlayerController+SYVidepPlayerCache.h"
#import "SYChoseVideoFrome.h"
#import "SYShareObject.h"
#import "SharePicController.h"
#import "SYHelperViewController.h"


@interface SYVideoPlayerController ()<WKNavigationDelegate>
///播放器
@property (nonatomic, strong) ZFPlayerController            *player;
///背景的View
@property (nonatomic, strong) UIView                        *containerView;
///播放控制器
@property (nonatomic, strong) ZFPlayerControlView           *controlView;
///后期弹幕输入
@property (nonatomic, strong) UITextField                   *textField;
///下面的评论
@property(strong,nonatomic)SYBootonInPutView                *inPutView;
///真实的视图
@property(strong,nonatomic)SYKeyBordInPutView               *keyBordInPutView;
///简介+选集
@property(strong,nonatomic)SYIntroductionView               *introductionView;
///此控制器的Model
@property(strong,nonatomic)PlayModel                        *palyModel;
///播放源的指针
@property(assign,nonatomic)NSInteger                        choseIndex;
///选集的指针
@property(assign,nonatomic)NSInteger                        setIndex;
///是否从头开始播放
@property(assign,nonatomic)BOOL                             isbeging;
///清晰度的指针
@property(assign,nonatomic)NSInteger                        clear;
///下面评论的切换
@property(assign,nonatomic)BOOL                             isNew;
///展开高度。。。
@property(assign,nonatomic)CGFloat                          cellShowheight;
///定义指向Cell 的指针
@property(strong,nonatomic)SYVideoSectionOneHeaderView      *header;
////定义指向只image的指针。。
@property(strong,nonatomic)UIImage                          *image;
////定义指向播放地址的URL
@property(strong,nonatomic)NSString                         *url;
////领导要求的常驻返回箭头。。
@property(strong,nonatomic)UIButton                         *backButton;
///自己反编译web
@property(strong,nonatomic)WKWebView                        *web;


@end


@implementation SYVideoPlayerController
#pragma mark - 处理头
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    self.player.viewControllerDisappear = NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    self.player.viewControllerDisappear = YES;
}
#pragma mark - 走的时候应该执行的方法！！！
-(void)viewDidDisappear:(BOOL)animated{
    [self upDataCache];
    if ([Tools isNeedLogin]) {
        return;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.video_id forKey:@"id"];
    [dict setObject:@(1) forKey:@"mid"];
    [dict setObject:@(4)forKey:@"eid"];
    NSString *floatstring = [NSString stringWithFormat:@"%lf",self.player.progress*100];
    [dict setObject:floatstring forKey:@"playTime"];
    if ([self.palyModel.info.url[0].list count]>0) {
        [dict setObject:@(self.setIndex+1)forKey:@"serlize"];
    }
    [dict setObject:@(self.choseIndex+1) forKey:@"play"];
    [HttpTool NOACtionPOST:[SY_event getWholeUrl] param:dict success:^(id responseObject) {
    } error:^(NSString *error) {
    }];
}
#pragma mark  - 加载部分
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self getMessage];
    [self gotCache];
    self.isNew=YES;
    self.isbeging=NO;
    [self addPlayer];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        if (iPhoneX) {
            make.top.mas_equalTo(self.view.mas_top).offset(40);
        }else{
            make.top.mas_equalTo(self.view.mas_top).offset(25);
        }
    }];
    [self.view addSubview:self.inPutView];
    [self.inPutView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }
        make.height.mas_equalTo(@40);
    }];
    [self addTableView];
    [self addOther];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - 布局部分
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
}
#pragma mark - 添加播放器
-(void)addPlayer{
    [self.view addSubview:self.containerView];
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [[ZFPlayerController alloc] initWithPlayerManager:playerManager containerView:self.containerView]; //
    self.player.controlView = self.controlView;
    self.player.pauseWhenAppResignActive = YES;
    [self.controlView showTitle:@"" coverImage:[UIImage imageNamed:@"bg"] fullScreenMode:ZFFullScreenModeLandscape];
    @weakify(self)
#pragma mark - 旋转
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        self.view.backgroundColor = isFullScreen ? [UIColor blackColor] : [UIColor whiteColor];
        [self.textField resignFirstResponder];
        [self setNeedsStatusBarAppearanceUpdate];
    };
#pragma mark - 旋转完成
    self.player.orientationDidChanged = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
           @strongify(self)
        if (!isFullScreen){
            [self.tableView reloadData];
        }
    };
#pragma mark - 播放完成
    self.player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        @strongify(self)
        //判断有资源
        [self nextSet];
    };
#pragma mark - 切换视频源！！！！
    __weak typeof(self)weakSelf = self;
    _controlView.changChoseIndex = ^{
        if (weakSelf.header&&!self.player.isFullScreen) {
            if (weakSelf.header.buttonClick) {
                weakSelf.header.choseButton.selected  = !weakSelf.header.choseButton.selected;
                weakSelf.header.buttonClick(@"选择视频");
            }
        }
    };
}
#pragma mark - 键盘弹上弹下的动作
- (void)keyboardWillShow:(NSNotification *)notification {
    if ([self.keyBordInPutView.textField isFirstResponder]) {
        CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        double animationTime = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 定义好动作
        void (^animation)(void) = ^void(void) {
            self.keyBordInPutView.transform = CGAffineTransformMakeTranslation(0, -(frame.size.height + self.keyBordInPutView.bounds.size.height));
        };
        if (animationTime > 0) {
            [UIView animateWithDuration:animationTime animations:animation];
        } else {
            animation();
        }
    }
}
-(void)keyBoardWillHide:(NSNotification*)notification{
    if ([self.keyBordInPutView.textField isFirstResponder]) {
        double animationTime = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 定义好动作
        void (^animation)(void) = ^void(void) {
            self.keyBordInPutView.transform = CGAffineTransformIdentity;
        };
        if (animationTime > 0) {
            [UIView animateWithDuration:animationTime animations:animation];
        } else {
            animation();
        }}
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}
#pragma mark- 键盘支持横屏，这里必须设置支持多个方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        if (self.keyBordInPutView.textField.isFirstResponder) {
            [self.keyBordInPutView.textField resignFirstResponder];
        }
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark -  播放器的控制器
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc]init];
        _controlView.fastViewAnimated=YES;
        __weak typeof(self)weakSelf = self;
        _controlView.choseAnyWithIndexAndStringAndType = ^(NSInteger index, NSString *title, viewType type) {
            if (type==choseClear) {
                VideoPlayInfo *videoPlayModel = [weakSelf getCache];
                videoPlayModel.lasttime = weakSelf.player.currentTime;
                weakSelf.clear =labs(index-4);
                [weakSelf saveDataWithModel:videoPlayModel];
                [weakSelf getPlayUrlWithString:weakSelf.palyModel.info.url[weakSelf.choseIndex].list[weakSelf.setIndex].url];
            }else if (type == choseSet){
                weakSelf.setIndex = index;
                weakSelf.isbeging=YES;
                [weakSelf isLastOne];
                [weakSelf getPlayUrlWithString:weakSelf.palyModel.info.url[weakSelf.choseIndex].list[weakSelf.setIndex].url];
            }
        };
        _controlView.nextPlayer = ^{
            [weakSelf nextSet];
        };
#pragma mark- 横竖屏的投屏
        _controlView.landScapeControlView.forsecreen = ^{
            [weakSelf searchTVWithModel:weakSelf.palyModel andWithURL:weakSelf.url];            
        };
        _controlView.portraitControlView.forScreen = ^{
            [weakSelf searchTVWithModel:weakSelf.palyModel andWithURL:weakSelf.url];
        };
#pragma mark - 到了定时关闭的时候了
        _controlView.clost = ^{
            
            if (weakSelf.player.isFullScreen) {
                [weakSelf.player enterFullScreen:NO animated:YES];
                [weakSelf close];
            }
        };
     }
    return _controlView;
    
}
#pragma mark - 播放器背景的图
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    return _containerView;
}
#pragma mark - 添加Tableview
-(void)addTableView{
    [self.view addSubview:self.tableView];//SYTableViewHeader.h
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.containerView.mas_bottom);
        make.bottom.mas_equalTo(self.inPutView.mas_top);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYVideoSectionOneHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SYVideoSectionOneHeaderView"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SYTableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"SYTableViewHeader"];
     [self.tableView registerNib:[UINib nibWithNibName:@"SYMessageCell" bundle:nil] forCellReuseIdentifier:@"SYMessageCell"];
    [self.tableView XJRegisHeadeORfootWithClass:@"SYHotPJTHeader"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
    imageView.image = [UIImage imageNamed:@"矩形 8 拷贝 66"];
    self.tableView.tableHeaderView = imageView;
}
#pragma mark - tableView的头部相关
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        SYVideoSectionOneHeaderView *headrView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYVideoSectionOneHeaderView"];
        self.header = headrView;
        headrView.contentView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self)weakSelf  = self;
        __weak typeof(headrView)weakHeaderView = headrView;
        headrView.buttonClick = ^(NSString * _Nonnull titleLabel) {
            if ([titleLabel isEqualToString:@"简介"]) {
                self.introductionView.viewtype = Introduction;
                [weakSelf popToView];
            }else if ([titleLabel isEqualToString:@"选择视频"]){
                //接下来下面弹窗了！！！！。。。。
                ZXJPopView *popView = [[ZXJPopView alloc]initWithFrame:self.view.frame];
                popView.dismisBlock = ^{
                    weakHeaderView.choseButton.selected = !weakHeaderView.choseButton.selected;
                };
                CGFloat height = [self.palyModel.info.url count]%2==0?[self.palyModel.info.url count]/2 *50+100:[self.palyModel.info.url count]/2*50+50+100; //计算弹出的高度………………
                SYChoseVideoFrome *choseitem = [[SYChoseVideoFrome alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height+10)];
                choseitem.info = self.palyModel.info;
                popView.contentview = choseitem;
                choseitem.cancelBlock = ^{
                    [popView dismissAlert];
                };
                    choseitem.choseItem = ^(NSInteger index) {
                    [popView dismissAlert];
                    weakSelf.choseIndex = index;
                    weakSelf.palyModel.info.url[index].list[weakSelf.setIndex].isSetseleted=YES;
                    [weakSelf.tableView reloadData];
                    [weakSelf getPlayUrlWithString:weakSelf.palyModel.info.url[weakSelf.choseIndex].list[weakSelf.setIndex].url];
                };
                
                [popView showAlert];
            }else if ([titleLabel isEqualToString:@"分享"]){
                __weak typeof(self)weakSelf = self;
                NSMutableArray *array =[[NSMutableArray alloc]init];
                [array addObjectsFromArray:SHAREARRAY];
                [array addObject:@"分享图片"];
                [SYShareObject shareWithController:self andWithImage:nil andWithUrl:[SYUSERINFO info].systemModel.shareURL andWithArray:array andBlock:^{
                    if (!self.image) return ;
                    SharePicController *controller = [[SharePicController alloc]init];
                    controller.info = self.palyModel.info;
                    controller.image = self.image;
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                }];
            }else if ([titleLabel isEqualToString:@"滚动"]){
                [weakSelf scrollViewToContentFrame];
            }else{
                [self.navigationController pushViewController:[SYHelperViewController new] animated:YES];
            };
        };
        headrView.info = self.palyModel.info;
        headrView.choseIndex = self.choseIndex;
        return headrView;
    }else if (section==1||section==2){
        SYTableViewHeader *headrView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYTableViewHeader"];
        headrView.contentView.backgroundColor= [UIColor whiteColor];
        headrView.click = ^{
          //点击更多的那个事件
        };
        if (section==2) {
            headrView.title.textColor = [UIColor darkTextColor];
            headrView.title.text = @"热门评论";
            [headrView.button setHidden:YES];
            headrView.hidden = [self.palyModel.hot_comment count]>0?NO:YES;
        }
        return headrView;
    }else if (section==3){
        SYHotPJTHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYHotPJTHeader"];
        [header.leftButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [header.rightButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        header.contentView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self)weakSelf = self;
        header.LeftClickOrRightClick = ^(NSString * _Nonnull title) {
            weakSelf.isNew=!weakSelf.isNew;
            [weakSelf.tableView reloadData];
        };
        header.hidden = [self.palyModel.comment count]>0?NO:YES;
        
        return header;
    }
    return nil;
}

#pragma mark - dataSouces 相关！
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 160;
    }else if (section==1){
        return 40;
    }else if (section==2){
        return [self.palyModel.hot_comment count]>0?40:CGFLOAT_MIN;
    }else if (section==3){
        return [self.palyModel.comment count]>0?40:CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}
#pragma mark - 高度相关！！！！
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if ([self.palyModel.info.type_id intValue]==1) {
                return CGFLOAT_MIN;
            }
            return 105;
        }else{
            return 60+self.cellShowheight;
        }
    }else if (indexPath.section==1){
        return ((SCREEN_WIDTH-4)/3/0.618)+21;
    }else if (indexPath.section==2||indexPath.section==3){
        videoPlayercomment *commed;
        if (indexPath.section==2) {
              commed  = self.palyModel.hot_comment[indexPath.row];
        }else{
             commed  = self.palyModel.comment[indexPath.row];
        }
        if (commed.height>0) {
            return commed.height;
        }else{
            CGFloat height = 77 + [Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:13] andWithText:commed.content andWithWidthMAX:SCREEN_WIDTH-35].height;
            commed.height = height;
            return commed.height;
        }
    }
    return 45;
}
#pragma mark- items相关
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return [self.palyModel.hot_comment count];
    }else{
        return self.isNew?[self.palyModel.comment count]:[self.palyModel.hot_comment count];
    }
 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
#pragma mark - cell 相关
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                if ([self.palyModel.info.type_id integerValue]!=1) {
                    NSString *idString  = @"idStrinhgIdis_xihdi";
                    SYVideoPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                    if (!cell) {
                        cell = [[SYVideoPlayerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
                    }
                    __weak typeof(self)weakSelf = self;
                    cell.selection_item = ^{
                        //选集
                        weakSelf.introductionView.viewtype = TV;
                        [weakSelf popToView];
                    };
                    
                    //选集
                    cell.itemSetClick = ^(NSInteger index) {
                        weakSelf.isbeging=YES;
                        weakSelf.setIndex = index;
                        [weakSelf.tableView reloadData];
                        [self isLastOne];
                        [weakSelf getPlayUrlWithString:weakSelf.palyModel.info.url[weakSelf.choseIndex].list[weakSelf.setIndex].url];
                    };
                    cell.info = self.palyModel.info;
                    cell.index = self.choseIndex;
                    return cell;
                    
                }else{
                    NSString *valString = @"reuseIdentifier";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:valString];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:valString];
                    }
                    return cell;
                }
            }else{
                NSString *string = @"SYVideoClass";
                SYVideoClass *cell  = [tableView dequeueReusableCellWithIdentifier:string];
                if (!cell) {
                     cell = [[SYVideoClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
                }
                __weak typeof(self)weakSelf = self;
                cell.sendHeight = ^(CGFloat Allheight) {
                    weakSelf.cellShowheight  = Allheight;
                    [weakSelf.tableView reloadData];
                };
                
                cell.labelArray = (NSMutableArray *)[self.palyModel.info.Class componentsSeparatedByString:@","];
                
                return cell;
            }
        }
        case 1:
        {
            NSString *idString  = @"idStrinhgIdis_xihdixce";
            SYGuessLikeCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
            if (!cell) {
                cell = [[SYGuessLikeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
            }
            cell.model = self.palyModel;
            __weak typeof(self)weakSelf = self;
            cell.collectionClick = ^(NSString * _Nonnull videoTypeID) {
                [weakSelf upDataCache];
                weakSelf.video_id = videoTypeID;
                [weakSelf gotCache];///重载缓存
                [weakSelf getMessage];///重载数据
                weakSelf.isbeging=NO;
            };
            return cell;
        }
        case 2:
        {
            //这个是热门的评论………………………………………………
            SYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYMessageCell"];
            videoPlayercomment *model = self.palyModel.hot_comment[indexPath.row];
            cell.cellType =PJVideo;
            cell.palyerComment = model;
            return cell;
        }
        break;
        case 3:
        {
            //这里是可以变化的！！！！
            SYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYMessageCell"];
            videoPlayercomment *model = self.isNew? self.palyModel.comment[indexPath.row]:self.palyModel.hot_comment[indexPath.row];
            cell.cellType =PJVideo;
            cell.palyerComment = model;
            return cell;
        }
        default:
            break;
    }
    return nil;
}


-(void)addOther{
    [self.view addSubview:self.keyBordInPutView];
}

-(SYBootonInPutView *)inPutView{
    __weak typeof(self)weakSelf = self;
    if (!_inPutView) {
        _inPutView = [[SYBootonInPutView alloc]initWithFrame:CGRectZero];
        _inPutView.buttonClick = ^(NSString * _Nonnull buttonTitle) {
            if ([buttonTitle isEqualToString:@"下载"]) {
                
            }else if ([buttonTitle isEqualToString:@"收藏"]){
                
            }else{
                //弹出键盘！！！！！！！！
                [weakSelf.keyBordInPutView.textField becomeFirstResponder];
            }
        };
    }
    return _inPutView;
}


//最下面的View
-(SYKeyBordInPutView *)keyBordInPutView{
    if (!_keyBordInPutView) {
        _keyBordInPutView = [Tools XJ_XibWithName:@"SYKeyBordInPutView"];
        _keyBordInPutView.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 50);
        __weak typeof(self)weakSelf =self;
        _keyBordInPutView.pjWithContent = ^(NSString * _Nonnull text) {
            [weakSelf gotoPjWithContent:text];
        };
    }
    return _keyBordInPutView;
}
//自定义弹窗视图！

-(SYIntroductionView *)introductionView{
    if (!_introductionView) {
        _introductionView = [[SYIntroductionView alloc]init];
        __weak typeof(self)weakSelf = self;
        _introductionView.close = ^{
            [weakSelf disMiss];
        };
        _introductionView.itemClick = ^(NSInteger index) {
            [weakSelf disMiss];
            [weakSelf.tableView reloadData];
            weakSelf.isbeging=YES;
            weakSelf.setIndex = index;
            [weakSelf isLastOne];
            [weakSelf getPlayUrlWithString:weakSelf.palyModel.info.url[weakSelf.choseIndex].list[weakSelf.setIndex].url];
        };
        _introductionView.backgroundColor = [UIColor whiteColor];
    }
    return _introductionView;
}
-(void)popToView{
    self.introductionView.index = self.choseIndex;
    [self.view addSubview:self.introductionView];
    self.introductionView.index = self.choseIndex;
    self.introductionView.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT-self.containerView.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.introductionView.frame = CGRectMake(0,self.containerView.bottom, SCREEN_WIDTH, SCREENH_HEIGHT-self.containerView.height);
    }];
}
-(void)disMiss{
    [UIView animateWithDuration:0.3 animations:^{
        self.introductionView.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT-self.containerView.bottom);
    }completion:^(BOOL finished) {
        [self.introductionView removeFromSuperview];
    }];
}
#pragma mark - getMessageToPlay
-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.video_id forKey:@"id"];
    [HttpTool POST:[SY_PlayInfo getWholeUrl] param:dict success:^(id responseObject) {
        self.palyModel = [PlayModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        [self addData];
    } error:^(NSString *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - 赋值部分
-(void)addData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.palyModel.info.pic]]];
    });
    if ([self.palyModel.ad.pic length]<1) {
        UIView *view = self.tableView.tableHeaderView;
        view.height = CGFLOAT_MIN;
        self.tableView.tableHeaderView = view;
    }else{
        UIImageView *imageView =(UIImageView *)self.tableView.tableHeaderView;
        imageView.height = 90;
        [imageView XJ_setImageWithURLString:self.palyModel.ad.pic];
        self.tableView.tableHeaderView = imageView;
    }
    self.introductionView.info = self.palyModel.info;
    self.palyModel.info.url[_choseIndex].isseleted =YES;
    self.palyModel.info.url[_choseIndex].list[_setIndex].isSetseleted = YES;
    [self.controlView.controller setSeleIndex:self.choseIndex andWithModel:self.palyModel.info];
    [self isLastOne];
    [self getPlayUrlWithString:self.palyModel.info.url[self.choseIndex].list[self.setIndex].url];
    [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.palyModel.info.url[self.choseIndex].list[self.setIndex].url]]];
    self.inPutView.store = self.palyModel.info.store;
    self.inPutView.videoID = self.video_id;
    self.controlView.landScapeControlView.isMoive = [self.palyModel.info.type_id intValue]!=1?NO:YES;
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",self->_web);
        
        
    });
}
-(void)gotoPjWithContent:(NSString *)content{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.video_id forKey:@"id"];
    [dict setObject:@(1) forKey:@"mid"];
    [dict setObject:content forKey:@"content"];
    [HttpTool POST:[SY_GotoPJ getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccessWithString:@"评论成功"];
        self.keyBordInPutView.textField.text = @"";
        videoPlayercomment *model = [videoPlayercomment mj_objectWithKeyValues:responseObject[@"data"]];
        [self.palyModel.comment insertObject:model atIndex:0];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}
-(void)getPlayUrlWithString:(NSString *)urlString {
    NSString *setString = self.palyModel.info.url[self.choseIndex].list[self.setIndex].title;
    if ([setString integerValue]>0) {
        setString = [NSString stringWithFormat:@"%@第%@集",self.palyModel.info.name,setString];
    }else{
        setString = self.palyModel.info.name;
    }
    [self.controlView showTitle:setString coverURLString:self.palyModel.info.pic fullScreenMode:ZFFullScreenModeLandscape];
    [self.player.currentPlayerManager stop];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:urlString forKey:@"url"];
    [dict setObject:@(self.clear) forKey:@"hd"];
    SYUSERINFO *system = [SYUSERINFO info];
    __weak typeof(self)weakSelf = self;
    [HttpTool NOACtionPOST:system.systemModel.vod_parse_url[0] param:dict success:^(id responseObject) {
        NSString *url = [[responseObject objectForKey:@"data"] objectForKey:@"url"];
        NSString *URLString = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.url = URLString;
        self.player.currentPlayerManager.assetURL = [NSURL URLWithString:URLString];
        if (!weakSelf.isbeging) {
            VideoPlayInfo *palyInfo = [weakSelf getCache];
            [weakSelf.player.currentPlayerManager setSeekTime:palyInfo.lasttime-10];
            weakSelf.isbeging = NO;
            [weakSelf.player.currentPlayerManager play];
        }
    } error:^(NSString *error) {
        
    }];

}
-(void)upDataCache{
    VideoPlayInfo *playInfo = [self getCache];
    playInfo.playClear = self.clear;
    playInfo.playTheSet = self.setIndex;
    playInfo.playTheSource = self.choseIndex;
    playInfo.lasttime = self.player.currentTime;
    playInfo.FLDBID = self.video_id;
    [self saveDataWithModel:playInfo];
}
-(void)gotCache{
    VideoPlayInfo *palyInfo = [self getCache];
    palyInfo.FLDBID = self.video_id;
    self.choseIndex = palyInfo.playTheSource;///播放源
    self.setIndex = palyInfo.playTheSet;///播放集数
    self.clear = palyInfo.playClear;///播放清晰度
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
#pragma mark - 移除通知和监听并向后台发送影视数据~~~~~！
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)close{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self)weakSelf   =  self;
        [self showAlrertWithTitle:@"定时关闭时间已到" andWithMessage:@"是否要关闭播放器？" andWithCancelButtonTitle:@"取消" andWithOKButtonTitle:@"关闭" andWithOKBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        
    });
}

-(void)scrollViewToContentFrame{
    CGRect rect =   [self.tableView rectForHeaderInSection:2];
    
    [self.tableView setContentOffset:CGPointMake(0, rect.origin.y) animated:YES];
}

-(void)nextSet{
    if ([self.palyModel.info.url[self.choseIndex].list count]-1>self.setIndex) {
        [self isLastOne];
        self.palyModel.info.url[self.choseIndex].list[self.setIndex].isSetseleted=NO;
        self.setIndex++;
        self.palyModel.info.url[self.choseIndex].list[self.setIndex].isSetseleted=YES;
        [self.controlView.controller setSeleIndex:self.choseIndex andWithModel:self.palyModel.info];
        [self getPlayUrlWithString:self.palyModel.info.url[self.choseIndex].list[self.setIndex].url];
        [self isLastOne];
        [self.tableView reloadData];
    }else{
        [self.player stop];
    }
}
-(void)isLastOne{
    if ([self.palyModel.info.url[self.choseIndex].list[self.setIndex] isEqual:self.palyModel.info.url[self.choseIndex].list.lastObject]) {
        self.controlView.isLastOneSet = YES;
    }else{
        self.controlView.isLastOneSet = NO;
    }
}

-(WKWebView *)web{
    if (!_web) {
        _web = [[WKWebView alloc]init];
    }
    return _web;
}

@end
