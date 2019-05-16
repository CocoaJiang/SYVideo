//
//  SYSearchTVController.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/30.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYSearchTVController.h"
#import "XHRadarView.h"
#import "SYSearchViewDevice.h"
#import "SYSearchDevicesCell.h"
#import "SY_ForScreenController.h"
@interface SYSearchTVController ()<DLNADelegate>
@property (nonatomic, strong) XHRadarView *radarView;
@property (nonatomic, strong) NSArray *pointsArray;
@property(strong,nonatomic)UIImageView *imageView;
@property(nonatomic,strong) MRDLNA *dlnaManager;
@property(nonatomic,strong) NSArray *deviceArr;
@property(strong,nonatomic)NSMutableArray *devicesNameArray;

@end
@implementation SYSearchTVController



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isForSeenTtype) {
       [self.dlnaManager startSearch];
    }
    
}

- (void)searchDLNAResult:(NSArray *)devicesArray{
    NSLog(@"发现设备");
    self.deviceArr = devicesArray;
    [self.devicesNameArray removeAllObjects];
    for (CLUPnPDevice *model in self.deviceArr) {
        [self.devicesNameArray addObject:model.friendlyName];
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    if (!self.isForSeenTtype) {
        self.title = @"选择设备投屏";
    }else
    {
        self.title = @"投屏助手";
        
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.dlnaManager = [MRDLNA sharedMRDLNAManager];
    self.dlnaManager.delegate = self;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (!self.isForSeenTtype) {
            return [self.deviceArr count]<=4? 200: [self.deviceArr count]*45+10;
        }else{
            return CGFLOAT_MIN;
        }
    }else{
        return self.imageView.size.height;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        NSString *idString = @"idSting";
        SYSearchDevicesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idString"];
        if (!cell) {
            cell = [[SYSearchDevicesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
        }
        __weak typeof(self)weakSelf  = self;
        cell.choseCell = ^(NSInteger index) {
            [weakSelf enterToController:index];
        };
        cell.array = (NSMutableArray *)_devicesNameArray;
        return cell;
        
    }else{
        NSString *idString = @"idStzzing";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idString"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idString];
            [cell.contentView addSubview:self.imageView];
            cell.contentView.bounds = self.imageView.bounds;
        }
        return cell;
    }
}


-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"airPlayInfo_pink"]];
        [_imageView sizeToFit];
        _imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _imageView.size.height);
    }
    return _imageView;
}

-(NSMutableArray *)devicesNameArray{
    if (!_devicesNameArray) {
        _devicesNameArray = [[NSMutableArray alloc]init];
    }
    return _devicesNameArray;
}


-(void)enterToController:(NSInteger)index{
    ////防止数组越界。。。
    if (index < [self.deviceArr count]) {
         NSString *testUrl = self.url;
        CLUPnPDevice *model = self.deviceArr[index];
        self.dlnaManager.device = model;
        self.dlnaManager.playUrl = testUrl;
        SY_ForScreenController *controller = [[SY_ForScreenController alloc]init];
        controller.model = self.model;
        controller.deviceModel = model;
        controller.video_id = self.video_id;
        __weak typeof(self)weakSelf = self;
        controller.back = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        [self presentViewController:controller animated:YES completion:nil];

    }
    
    
    
    
}







@end
