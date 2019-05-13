//
//  SYLiveSetController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/23.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYLiveSetController.h"

#import "LiveControllerHeader.h"

#import "UIScrollView+EmptyDataSet.h"

#import "SYlivePlayer.h"

#import "LiveModel.h"

#import "LiveListModel.h"

@interface SYLiveSetController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIGestureRecognizerDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)LiveControllerHeader *header;
@property(strong,nonatomic)NSMutableArray *dataSorces;
///定义偏移指针
@property(assign,nonatomic)NSInteger chosChannel;


/*
 
 */


@end


@implementation SYLiveSetController


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        ///开启异步线程。。。。
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self getMessage];
        });
        
        self.chosChannel = 0;
        
        
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.tableView];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(self);
            make.width.mas_equalTo(SCREEN_WIDTH/3);
        }];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 50)];
        [view addSubview:self.header];
        [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
        }];
        self.tableView.tableHeaderView  =  view;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *zer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewdismiss)];
        zer.delegate =self;
        [self addGestureRecognizer:zer];
        //利用KVO 监听 指针。。。
        [self addObserver:self forKeyPath:@"chosChannel" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"chosChannel"]) {
        if (self.chosChannel==0) {
            [self.header.leftbutton setHidden:YES];
        }else{
            [self.header.leftbutton setHidden:NO];
        }
        if ([self.dataSorces count]-1==self.chosChannel) {
            [self.header.rightButton setHidden:YES];
        }else{
            [self.header.rightButton setHidden:NO];
        }
        if (self.type == SYLiveSetControllerchangIndex) {
            LiveModel *model = self.dataSorces[self.chosChannel];
            _header.title.text = model.name;
        }
        
    }
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"chosChannel"];
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate= self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.backgroundColor = RGBA(0, 0, 0, 0.5);
        [_tableView setHidenLine];
        [_tableView setOthers];
        _tableView.rowHeight = 50;
    }
    return _tableView;
}


#pragma mark -delegate and dataSouces

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *idString  =  @"idfesting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idString];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.contentView.backgroundColor = cell.backgroundColor = [UIColor clearColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (self.type==SYLiveSetControllerchangSetIndex) {
        routeModel *model  = self.array_choseSetIndex[indexPath.row];
        cell.textLabel.text = model.name;
        cell.detailTextLabel.hidden = YES;
        if (model.isSeted) {
            cell.textLabel.textColor  = KAPPMAINCOLOR;
        }else{
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        return cell;
        
    }else if (self.type == SYLiveSetControllerchangIndex){
        cell.detailTextLabel.hidden = NO;
        LiveListModel *model = self.array_choseIndex[indexPath.row];
        if (model.isSeleted) {
            cell.textLabel.textColor = cell.detailTextLabel.textColor = KAPPMAINCOLOR;
        }else{
            cell.textLabel.textColor = cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        cell.textLabel.text = model.name;
        cell.detailTextLabel.text = model.program;
        
        return cell;
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type==SYLiveSetControllerchangSetIndex) {
            return [self.array_choseSetIndex count];
    }else if (self.type == SYLiveSetControllerchangIndex){
        return [self.array_choseIndex count];
    }else{
        return 0;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == SYLiveSetControllerchangSetIndex) {
        //进行回调吗！？
        for (routeModel *model in self.array_choseSetIndex) {
            model.isSeted  = NO;
        }
        routeModel *model = self.array_choseSetIndex[indexPath.row];
        model.isSeted = YES;
        if (self.ChoseCell) {
            NSString *URLString = [model.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            self.ChoseCell([NSURL URLWithString:URLString]);
        }
        [self.tableView reloadData];
    }else if (self.type == SYLiveSetControllerchangIndex){
        
        
        ////先拿到当前的iD
        
        
        LiveModel *LModel = self.dataSorces[_chosChannel];
        
        LiveListModel *model = LModel.array[indexPath.row];
        
        for (LiveModel *liveModel in self.dataSorces) {
            
            for (LiveListModel *livelistModel in liveModel.array) {
                
                if ([livelistModel.ID isEqualToString:model.ID]) {
                    
                    livelistModel.isSeleted = YES;
                    
                }else{
                    livelistModel.isSeleted = NO;
                }
                
            }
        }
        
        [self reloadData];
        
        if (self.changchnel) {
            self.changchnel(model);
        }
        
        
        
    }
}


-(void)setType:(SYLiveSetControllerType)type{
    _type = type;
    if (type==SYLiveSetControllerchangSetIndex) {
        _header.title.text = @"选择播放源";
        _header.leftbutton.hidden = _header.rightButton.hidden = YES;
    }else if (type==SYLiveSetControllerchangIndex){
        if (self.chosChannel==0) {
            [self.header.leftbutton setHidden:YES];
        }else{
            [self.header.leftbutton setHidden:NO];
        }
        if ([self.dataSorces count]-1==self.chosChannel) {
            [self.header.rightButton setHidden:YES];
        }else{
            [self.header.rightButton setHidden:NO];
        }
    }
    [self reloadData];
    
}

-(LiveControllerHeader *)header{
    if (!_header) {
        _header = [Tools XJ_XibWithName:@"LiveControllerHeader"];
        
        __weak typeof(self)weakSelf = self;
        _header.buttonClick = ^(NSString * _Nonnull title) {
            if ([title isEqualToString:@"right"]) {
                weakSelf.chosChannel++;
                if (self.chosChannel<=[self.dataSorces count]-1) {
                    LiveModel *model = weakSelf.dataSorces[weakSelf.chosChannel];
                    if (model.array) {
                        weakSelf.array_choseIndex = model.array;
                    }else{
                        [weakSelf getFistDataWithModel:model];
                    }
                }
            }else{
                if (weakSelf.chosChannel==0) return;
                weakSelf.chosChannel--;
                LiveModel *model = weakSelf.dataSorces[weakSelf.chosChannel];
                if (model.array) {
                    weakSelf.array_choseIndex = model.array;
                }else{
                    [weakSelf getFistDataWithModel:model];
                }
            }
             [weakSelf reloadData];
        };
    }
    return _header;
}
#pragma mark 当数据为空的时候走这个..............................................................................
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                 };
    return [[NSAttributedString alloc] initWithString:@"暂无线路可选" attributes:attributes];
}
-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [Tools EmptyImage];
}
///调整图片的位置
-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 100;
}
#pragma mark - 处理点击退回事件
-(void)viewdismiss{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}
#pragma mark - 筛选手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view.size.width<self.frame.size.width && ![touch.view isKindOfClass:[UITableView class]]) {
        return NO; //让其相应collectionView的点击事件！！！
    }
    return YES;
}

#pragma mark - set事件。。。。。
-(void)setArray_choseSetIndex:(NSMutableArray *)array_choseSetIndex{
    _array_choseSetIndex = array_choseSetIndex;
    [self.tableView reloadData];
}


#pragma mark - setArray;;;;

-(NSMutableArray *)dataSorces{
    if (!_dataSorces) {
        _dataSorces = [[NSMutableArray alloc]init];
    }
    return _dataSorces;
}
-(NSMutableArray *)array_choseIndex{
    if (!_array_choseIndex) {
        _array_choseIndex = [[NSMutableArray alloc]init];
    }
    return _array_choseIndex;
}

#pragma mark  -做大量数据。。。请求
-(void)getMessage{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [HttpTool NOACtionPOST:[SY_Live getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dictionay in [responseObject objectForKey:@"data"]) {
            LiveModel *model = [LiveModel mj_objectWithKeyValues:dictionay];
            [self.dataSorces addObject:model];
            
        }
        if ([self.dataSorces count]<1)return ;
        LiveModel *model_quest = self.dataSorces[self.chosChannel];
        self->_header.title.text = model_quest.name;
        [self getFistDataWithModel:model_quest];
    } error:^(NSString *error) {
        
    }];
}

#pragma mark - 第一次请求。。。。加载第一次请求的数据。。和进行存储

-(void)getFistDataWithModel:(LiveModel *)model{
    
    model.array = [NSMutableArray array];
    [self.array_choseIndex removeAllObjects];
    [model.array removeAllObjects];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:model.id forKey:@"id"];
    [dict setObject:@(30) forKey:@"pageSize"];
    [HttpTool NOACtionPOST:[SY_liveList getWholeUrl] param:dict success:^(id responseObject) {
        for (NSDictionary *dict in [[responseObject objectForKey:@"data"] objectForKey:@"list"]) {
            LiveListModel *model_index  = [LiveListModel mj_objectWithKeyValues:dict];
            [self.array_choseIndex addObject:model_index];
            [model.array addObject:model_index];
            if ([model_index.ID isEqualToString:self.idString]) {
                model_index.isSeleted  =  YES;
            }
        }
        [self reloadData];
    } error:^(NSString *error) {
        
    }];
}

-(void)reloadData{
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

-(void)setIdString:(NSString *)idString{
    _idString = idString;
}


@end
