//
//  LiveListModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/4/22.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XWDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveListModel : NSObject<XWDatabaseModelProtocol>
@property(copy,nonatomic)NSString *ID;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *program;
@property(assign,nonatomic)NSInteger time;
///是否选中
@property(assign,nonatomic)BOOL isSeleted;





@end

NS_ASSUME_NONNULL_END
