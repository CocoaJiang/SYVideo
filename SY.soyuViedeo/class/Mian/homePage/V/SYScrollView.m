//
//  SYScrollView.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/13.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYScrollView.h"
#import "SDCycleScrollView.h"
#import "HomePageModel.h"
#import "SYVideoPlayerController.h"

@interface SYScrollView ()<SDCycleScrollViewDelegate>
@property(strong,nonatomic)SDCycleScrollView *cycleScrollView;

@end


@implementation SYScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cycleScrollView];
    }
    return self;
}

-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"矩形 8 拷贝 2"]];
        _cycleScrollView.showPageControl=YES;
        _cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.pageControlStyle  = SDCycleScrollViewPageContolStyleClassic;
        _cycleScrollView.currentPageDotColor =KappBlue;
        _cycleScrollView.clipsToBounds = YES;
    }
    return _cycleScrollView;
}

-(void)setArray:(NSMutableArray *)array{
    NSMutableArray *imageURlArray = [[NSMutableArray alloc]init];
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    for (recommendModel *slierModel in array) {
        NSString *title = [NSString stringWithFormat:@"%@:%@",slierModel.name,slierModel.sub_name];
        [titleArray addObject:title];
        [imageURlArray addObject:slierModel.pic];
    }
    self.cycleScrollView.imageURLStringsGroup = imageURlArray;
    self.cycleScrollView.titlesGroup = titleArray;
}

-(void)layoutSubviews{
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    recommendModel *model = self.array[index];
    if ([model.link_type integerValue]==0&&model.id) {
        SYVideoPlayerController *controller = [[SYVideoPlayerController alloc]init];
        controller.video_id =model.id;
        [[Tools viewController:self].navigationController pushViewController:controller animated:YES];
    }else if ([model.link_type integerValue]==1){
        //广告直接跳转
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1061880281"]];
    }
}



@end
