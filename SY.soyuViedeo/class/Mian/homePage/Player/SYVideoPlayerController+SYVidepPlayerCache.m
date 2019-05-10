//
//  SYVideoPlayerController+SYVidepPlayerCache.m
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/10.
//  Copyright © 2019 搜云. All rights reserved.
//

#import "SYVideoPlayerController+SYVidepPlayerCache.h"
#import "SYSearchTVController.h"
#import <XWDatabase.h>
@implementation SYVideoPlayerController (SYVidepPlayerCache)
/////更新存储框架
-(VideoPlayInfo *)getCache{
    ///每次进来的时候先创建一个表
    VideoPlayInfo *info = [[VideoPlayInfo alloc]init];
    info.FLDBID = @"1008611";
    [XWDatabase saveModel:info completion:^(BOOL isSuccess) {
        
    }];
    __block VideoPlayInfo *videoPlayer = [[VideoPlayInfo alloc]init];
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    videoPlayer.FLDBID = self.video_id;
    
    [XWDatabase getModel:videoPlayer identifier:self.video_id completion:^(id  _Nullable obj) {
        videoPlayer = obj;
        if (videoPlayer==nil) {
            videoPlayer = [[VideoPlayInfo alloc] init];
            videoPlayer.FLDBID = self.video_id;
            videoPlayer.playTheSource = 0;
            videoPlayer.playTheSet = 0;
            videoPlayer.playClear=1;
            videoPlayer.lasttime = 0;
            [XWDatabase saveModel:videoPlayer identifier:self.video_id completion:^(BOOL isSuccess) {
                
            }];
            
            dispatch_semaphore_signal(signal);
            
        }else{
            dispatch_semaphore_signal(signal);
        }
        
    }];
    

    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    
    return videoPlayer;

}


-(void)saveDataWithModel:(VideoPlayInfo *)videoPlayer{
    [XWDatabase saveModel:videoPlayer identifier:self.video_id completion:^(BOOL isSuccess) {
        
    }];
}
-(void)searchTVWithModel:(PlayModel *)model andWithURL:(NSString *)urlString{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SYSearchTVController *controller = [[SYSearchTVController alloc]init];
        controller.model = model;
        controller.url = urlString;
        controller.video_id = self.video_id;
        [self.navigationController pushViewController:controller animated:YES];
    });
}






@end
