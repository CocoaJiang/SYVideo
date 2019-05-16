//
//  SYHotDetail.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/21.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYHotDetail.h"
#import "SYHotTableViewHeader.h"
#import "SYHotPlayerCell.h"
#import "SYMessageCell.h"
#import "SYTableViewHeader.h"
#import "SYHotPJTHeader.h"
#import <WebKit/WebKit.h>
#import "LKPagerView.h"
#import "SYHotFootView.h"
#import "SYTopDetailModel.h"
#import <JhtMarquee/JhtHorizontalMarquee.h>
#import <JhtMarquee/JhtHorizontalMarquee_Define.h>
#import "SYBootonInPutView.h"
#import "SYKeyBordInPutView.h"
#import "IQKeyboardManager.h"
#import "SYVideoPlayerController.h"
#import "SYShareObject.h"
#import "SYHotHeaderView.h"
@interface SYHotDetail ()<LKPagerViewDataSource,LKPagerViewDelegate>
@property(strong,nonatomic)SYHotTableViewHeader *header;
@property(strong,nonatomic)WKWebView *wkWebView;
@property(assign,nonatomic)NSInteger index;
@property(assign,nonatomic)CGFloat webViewHeight;//webView的高度！
@property(strong,nonatomic)LKPagerView *pagerView;
@property(strong,nonatomic)NSMutableArray *imageArray;
@property(strong,nonatomic)SYHotFootView *hotFootView;
@property(strong,nonatomic)SYTopDetailModel *model;
@property(strong,nonatomic)JhtHorizontalMarquee *quee;
@property(strong,nonatomic)SYBootonInPutView *inPutView;
@property(strong,nonatomic)SYKeyBordInPutView *keyBordInPutView;
///算一次高度 节省内存
@property(assign,nonatomic)CGFloat titleStringHeightAndSpeaceHeight;
///容器View
@property(strong,nonatomic)SYHotHeaderView *headerView;

#define DETAILCOLOR RGBA(144,152,184,1)

@end


@implementation SYHotDetail
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat height = [Tools XJCalculateTheSizeWithFont:[UIFont boldSystemFontOfSize:25] andWithText:self.titleString andWithWidthMAX:SCREEN_WIDTH-20].height;
    self.titleStringHeightAndSpeaceHeight = height+40;
    [self setNAV];
    self.index = 0;
    [self getMessage];
    [self addUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
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
    double animationTime = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.keyBordInPutView.transform = CGAffineTransformIdentity;
    };
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

#pragma mark - SetNAV
-(void)setNAV{
    self.navigationItem.hidesBackButton = YES;
    JhtHorizontalMarquee *quee = [[JhtHorizontalMarquee alloc]initWithFrame:CGRectMake(100 , 0, SCREEN_WIDTH-100, 40) singleScrollDuration:0.0];
    quee.font =[UIFont systemFontOfSize:16];
    self.navigationItem.titleView = quee;
    self.navigationItem.titleView.bounds  = quee.bounds;
    quee.textColor = DETAILCOLOR;
    quee.text = self.titleString;
    self.quee =  quee;
    [self.quee setHidden:YES];
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setImage:[UIImage imageNamed:@"ico_nav_back"] forState:UIControlStateNormal];
    buttonBack.size = CGSizeMake(30, 50);
    UIBarButtonItem *tem = [[UIBarButtonItem alloc]initWithCustomView:buttonBack];
    self.navigationItem.leftBarButtonItem = tem;
    buttonBack.tag = 100;
    [buttonBack addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setImage:[UIImage imageNamed:@"icon_video_share"] forState:UIControlStateNormal];
    rightbutton.tag = 101;
    rightbutton.size = CGSizeMake(30, 50);
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = item;
     [rightbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClick:(UIButton *)button{
    if (button.tag==100) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }else{
        [SYShareObject shareWithController:self andWithImage:nil andWithUrl:[SYUSERINFO info].systemModel.shareURL andWithArray:SHAREARRAY andBlock:nil];
    }
}


//#pragma mark - 隐藏相关！！！
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBarTintColor:RGBA(75, 82, 101, 1)];
    self.navigationController.navigationBar.translucent = NO;
    [self.quee marqueeOfSettingWithState:MarqueeStart_H];
    [IQKeyboardManager sharedManager].enable=NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBarTintColor:KAPPMAINCOLOR];
    [self.quee marqueeOfSettingWithState:MarqueeShutDown_H];
    [IQKeyboardManager sharedManager].enable = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = nil;

}
#pragma mark - 控件相关……………………
-(void)addUI{
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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.inPutView.mas_top);
    }];
    [self.view addSubview:self.keyBordInPutView];
    self.view.backgroundColor =RGBA(75, 82, 101, 1);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView XJRegisCellWithNibWithName:@"SYHotPlayerCell"];
    [self.tableView XJRegisCellWithNibWithName:@"SYMessageCell"];
    [self.tableView XJRegisHeaderOrFooterforNibWithName:@"SYTableViewHeader"];
    [self.tableView XJRegisHeadeORfootWithClass:@"SYHotPJTHeader"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.titleStringHeightAndSpeaceHeight)];
    self.tableView.tableHeaderView = view;
    [view addSubview:self.headerView];
    [_headerView sizeToFit];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(view);
        make.height.mas_equalTo(@(self.titleStringHeightAndSpeaceHeight-1));
    }];
    [view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
    }];

}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else  if (section==1) {
        if ([self.model.info.vedio count]>=self.index+1) {
            videoDetail *model  = self.model.info.vedio[self.index];
            return [model.relate count];
        }else{
            return 0;
        }
    }else{
        return [self.model.comment.list count];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }else if (section==1) {
        SYTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYTableViewHeader"];
        [header.button setHidden:YES];
        header.contentView.backgroundColor=[UIColor clearColor];
        header.title.textColor =DETAILCOLOR;
        header.title.text = @"相关推荐";
        if ([self.model.info.vedio count]>=self.index+1) {
            videoDetail *model  = self.model.info.vedio[self.index];
            header.hidden = [model.relate count]>0?NO:YES;
        }else{
            header.hidden=YES;
        }
        return header;
    }else{
        SYHotPJTHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SYHotPJTHeader"];
        header.LeftClickOrRightClick = ^(NSString * _Nonnull title) {
          //刷新数据的地方！！！！
        };
        return header;
    }
}

#pragma mark -高度相关………………

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return [self.imageArray count]>0?220:0;
        }else{
            return [self.imageArray count]>0?200:0;
        }
    }else if (indexPath.section==1) {
        return 50;
    }else{
        commentDetail *model = self.model.comment.list[indexPath.row];
        if (model.height>0) {
            return model.height;
        }else{
            CGFloat height = 77+[Tools XJCalculateTheSizeWithFont:[UIFont systemFontOfSize:13] andWithText:model.content andWithWidthMAX:SCREEN_WIDTH-36].height;
            model.height = height;
            return height;
        }
    }
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGFLOAT_MIN;
    }else if (section==1){
        if ([self.model.info.vedio count]>=self.index+1) {
            videoDetail *model  = self.model.info.vedio[self.index];
            return  [model.relate count]>0?40 :CGFLOAT_MIN;
        }else{
            return CGFLOAT_MIN;
        }
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

#pragma mark - 复杂逻辑集中

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
            {
                NSString *idString = @"IDString";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
                    cell.backgroundColor = cell.contentView.backgroundColor = [UIColor clearColor];
                    [cell.contentView addSubview:self.pagerView];
                    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.mas_equalTo(cell.contentView);
                    }];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

                }
                return cell;
 
            }
            case 1:
            {
                NSString *idString = @"IDStringITUY";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
                    cell.backgroundColor = cell.contentView.backgroundColor = [UIColor clearColor];
                    [cell.contentView addSubview:self.hotFootView];
                    [self.hotFootView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.edges.mas_equalTo(cell.contentView);
                    }];
                }
                if (self.model.info.vedio.count>=self.index+1) {
                    self.hotFootView.detailModel = self.model.info.vedio[self.index];
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
                return cell;
            }
                break;
            default: return nil;
                break;
            
        }
        
    
    }else if (indexPath.section==1) {
        SYHotPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYHotPlayerCell"];
        cell.contentView.backgroundColor = [UIColor clearColor];
        if ([self.model.info.vedio count]>=self.index+1) {
            videoDetail *model  = self.model.info.vedio[self.index];
            recommendDetail *recommendDetail = model.relate[indexPath.row];
            cell.title.text  = recommendDetail.name;
        }
        return cell;
    }else{
        SYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYMessageCell"];
        cell.model = self.model.comment.list[indexPath.row];
        cell.contentView.backgroundColor=cell.backgroundColor =cell.countent.backgroundColor= [UIColor clearColor];
        cell.countent.textColor = cell.lineView.backgroundColor = cell.titile.textColor = cell.time.textColor = DETAILCOLOR;
        cell.cellType = PJHotCell;
        cell.lineView.backgroundColor = DETAILCOLOR;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
        videoDetail *model  = self.model.info.vedio[self.index];
        recommendDetail *recommendDetail =model.relate[indexPath.row];
        controller.video_id =recommendDetail.id;
        [self.navigationController pushViewController:controller animated:YES];
    }
}



#pragma mark - 懒加载
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        //[ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#9098b8'" completionHandler:nil];
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta) ;document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#9098b8'; var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:wkWebConfig];
        _wkWebView.scrollView.showsVerticalScrollIndicator=NO;
        _wkWebView.scrollView.showsHorizontalScrollIndicator = NO;
        _wkWebView.backgroundColor = [UIColor clearColor];
        [_wkWebView setOpaque:NO];
        _wkWebView.scrollView.scrollEnabled = NO;
        [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _wkWebView;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        NSLog(@"==================================================%f================================",_wkWebView.scrollView.contentSize.height);
        
        if (self.webViewHeight==_wkWebView.scrollView.contentSize.height ||  _wkWebView.scrollView.contentSize.height-self.webViewHeight ==2) {
            return;
        }else{
           UIView *view = self.tableView.tableHeaderView;
          self.webViewHeight = _wkWebView.scrollView.contentSize.height;
           view.height = self.webViewHeight+100;
           self.tableView.tableHeaderView = view;
            self.tableView.tableHeaderView.height = _webViewHeight+100;
            
        }
    }
}



- (NSInteger)numberOfItemsInPagerView:(LKPagerView *)pagerView
{
    return self.imageArray.count;
}

- (LKPagerViewCell *)pagerView:(LKPagerView *)pagerView cellForItemAtIndex:(NSInteger)index
{
    LKPagerViewCell * cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cell" atIndex:index];
    [cell.imageView XJ_setImageWithURLString:self.imageArray[index]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;
    return cell;
}

#pragma mark - LKPagerViewDelegate


//这是用户滚动了

- (void)pagerView:(LKPagerView *)pagerView didEndDisplayingCell:(LKPagerViewCell *)cell forItemAtIndex:(NSInteger)index{
    self.index = pagerView.currentIndex;
    [self.tableView reloadData];
}
-(LKPagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[LKPagerView alloc]init];
        [_pagerView registerClass:[LKPagerViewCell class] forCellWithReuseIdentifier:@"cell"];
        _pagerView.delegate = self;
        _pagerView.dataSource = self;
        _pagerView.isInfinite = YES;
        _pagerView.scrollDirection = LKPagerViewScrollDirectionHorizontal;
        _pagerView.transformer = [[LKPagerViewTransformer alloc] initWithType:LKPagerViewTransformerTypeCoverFlow ];
        _pagerView.itemSize = CGSizeMake(160, 220);
        _pagerView.currentIndex=0;
    }
    return _pagerView;
}


-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc]init];
        NSArray *imageNames = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg"];
        [_imageArray addObjectsFromArray:imageNames];
    }
    return _imageArray;
}

-(void)dealloc{
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

/*去掉Header的弹性*/
-(SYHotFootView *)hotFootView{
    if (!_hotFootView) {
        _hotFootView = [Tools XJ_XibWithName:@"SYHotFootView"];
    }
    return _hotFootView;
}

#pragma mark - 加载数据进行渲染

-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [dict setObject:@(self.SYindex) forKey:@"page"];
    [dict setObject:@"20" forKey:@"pageSize"];
    [HttpTool POST:[SY_TopICDetail getWholeUrl] param:dict success:^(id responseObject) {
        self.model = [SYTopDetailModel mj_objectWithKeyValues:[responseObject objectForKey:@"data"]];
        //接下来分发数据。。。
        [self addData];
    } error:^(NSString *error) {
    
    }];
}

-(void)addData{
    //第一步webBiew
    [_wkWebView loadHTMLString:self.model.info.content baseURL:nil];
    //第二取出滚动图
    [self.imageArray removeAllObjects];
    for (videoDetail *video in self.model.info.vedio) {
        [self.imageArray addObject:video.pic];
    }
    [self.pagerView reloadData];
    self.pagerView.hidden=self.hotFootView.hidden=[self.imageArray count]>0?NO:YES;

    [self.tableView reloadData];
}



-(SYBootonInPutView *)inPutView{
    __weak typeof(self)weakSelf = self;
    if (!_inPutView) {
        _inPutView = [[SYBootonInPutView alloc]initWithFrame:CGRectZero];
        _inPutView.type = Nobutton;
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
        _keyBordInPutView.frame = CGRectMake(0,SCREENH_HEIGHT-kTopHeight, SCREEN_WIDTH, 50);
        __weak typeof(self)weakSelf =self;
        _keyBordInPutView.pjWithContent = ^(NSString * _Nonnull text) {
            [weakSelf gotoPjWithContent:text];
        };
    }
    return _keyBordInPutView;
}

//处理评论事件……………………
-(void)gotoPjWithContent:(NSString *)content{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:self.idString forKey:@"id"];
    [dict setObject:@(3) forKey:@"mid"];
    [dict setObject:content forKey:@"content"];
    [HttpTool POST:[SY_GotoPJ getWholeUrl] param:dict success:^(id responseObject) {
        [Tools showSuccessWithString:@"评论成功"];
        self.keyBordInPutView.textField.text = @"";
        commentDetail *model = [commentDetail mj_objectWithKeyValues:responseObject[@"data"]];
        [self.model.comment.list insertObject:model atIndex:0];
        [self.tableView reloadData];
    } error:^(NSString *error) {
        
    }];
}


#pragma mark  -  隐藏逻辑 问题。。。

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y>kTopHeight) {
        [self.quee setHidden:NO];
    }else{
        [self.quee setHidden:YES];
    }
}


#pragma mark - headerView。。。。。。。。。。。。。。。
-(SYHotHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SYHotHeaderView alloc]initWithFrame:CGRectZero];
        _headerView.title.text = self.titleString;
        _headerView.title.textColor = _headerView.timeLanel.textColor = DETAILCOLOR;
        _headerView.timeLanel.text = @"2010.20.90";
        [_headerView.title sizeToFit];
    }
    return _headerView;
}






@end
