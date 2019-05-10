//
//  UITableView+ZXJTableviewCategory.m
//  乐氏同仁APP
//
//  Created by 张孝江 on 2018/9/6.
//  Copyright © 2018年 双木科技张晓红. All rights reserved.
//

#import "UITableView+ZXJTableviewCategory.h"

@implementation UITableView (ZXJTableviewCategory)

-(void)setHidenLine{
    
    self.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.showsVerticalScrollIndicator = NO;
    
    self.showsHorizontalScrollIndicator = NO;
    
}

-(void)setOthers{
    
    
    self.estimatedSectionFooterHeight = 0;
    
    self.estimatedRowHeight = 0;
    
    self.estimatedSectionHeaderHeight = 0;
    
}


-(void)XJRegisCellWithNibWithName:(NSString *)name{
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
}

-(void)XJRegisHeaderOrFooterforNibWithName:(NSString *)name{
    [self registerNib:[UINib nibWithNibName:name bundle:nil] forHeaderFooterViewReuseIdentifier:name];
}

-(void)XJRegisHeadeORfootWithClass:(NSString *)className{
    [self registerClass:NSClassFromString(className) forHeaderFooterViewReuseIdentifier:className];
}


@end
