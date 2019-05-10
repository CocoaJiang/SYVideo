//
//  FindModel.h
//  SY.soyuViedeo
//
//  Created by 搜云 on 2019/3/26.
//  Copyright © 2019 搜云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class rankModel;


@interface FindModel : NSObject
@property(copy,nonatomic)NSString *type_id;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSArray<rankModel *> *data;




@end



@interface hotModel : NSObject
@property(copy,nonatomic)NSString * id;
@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * pic;
@property(copy,nonatomic)NSString * time_format;
//缓存文字的高度。。。。。
@property(assign,nonatomic)CGFloat height;
@end


@interface rankModel:NSObject
@property(copy,nonatomic)NSString *trend;
@property(copy,nonatomic)NSString *id;
@property(copy,nonatomic)NSString *pic;
@property(copy,nonatomic)NSString *blurb;
@property(copy,nonatomic)NSString *Class;
@property(copy,nonatomic)NSString *rank;
@property(copy,nonatomic)NSString *name;
@end





NS_ASSUME_NONNULL_END

/*
code = 0,
message = "成功",
data =     (
            {
                type_id = 1,
                name = "电影",
                data =     (
                            {
                                trend = 0,
                                id = 950,
                                pic = "http://pic.tudou1238.com/upload/vod/2019-01-17/15477343940.jpg",
                                blurb = "影片讲述小巡警菊川玲二被要求在黑社会中充当卧底，并伸张正义的故事此次的续集从标题上便可得知，故事舞台背景放到了中国香港，被奉命摧毁中国黑手党组织仙骨龙的菊川玲二再次遇上了前所未有的危机。",
                                class = "日本 / 喜剧",
                                rank = "No.1",
                                name = "鼹鼠之歌2：香港狂骚曲",
                            },
                            {
                                trend = 0,
                                id = 907,
                                pic = "http://pic.tudou1238.com/upload/vod/2019-01-17/15477379830.jpg",
                                blurb = "师徒四人途径西凉境地一进城就感受到阴森之感。后来经过几次探索之后，悟空发现竟是狐妖作祟，几番周折以后，悟空使记将狐妖捉拿，谁知狐妖竟迷惑八戒，使得八戒与悟空，沙...",
                                class = "大陆 / 喜剧",
                                rank = "No.2",
                                name = "西游之女妖王",
                            },
                            {
                                trend = 0,
                                id = 926,
                                pic = "http://pic.tudou1238.com/upload/vod/2019-01-17/15477369680.jpg",
                                blurb = "20岁的董佳佳（何宁宁饰）是一名大学生，也是一位网络主播直播过程中，董佳佳突然收到巨额礼物，随之而来的爱情不仅有幸福，还有突然而来的孩子。沉浸于幸福中的她忽然遭遇“被小三”，面临最残酷的“人生选择”。",
                                class = "大陆 / 爱情",
                                rank = "No.3",
                                name = "非常突然",
                            },
                            {
                                trend = 0,
                                id = 609,
                                pic = "http://192.168.10.192/tu.php?tu=img24.pplive.cn/cs180x240/2018/04/11/18243682756.jpg",
                                blurb = "漂亮精悍的出租车司机小凤（马晓晴 饰）和安于近况的小号手年夜明（葛优 饰）是一对成婚两年多的小夫妻，柴米油盐酱醋茶，各种糊口近况让他们的感情呈现了成绩小凤厌弃年夜明不求长进，年夜明则同心专心想要孩子却",
                                class = "剧情",
                                rank = "No.4",
                                name = "离婚大战",
                            },
                            {
                                trend = 0,
                                id = 318,
                                pic = "http://192.168.10.192/tu.php?tu=puui.qpic.cn/vcover_vt_pic/0/iwk7d8ou6pdk8j81523609162/220",
                                blurb = "美国内战时期，饱受创伤的前军官约翰·卡特（泰勒·克奇 Taylor Kitsch 饰）无意间穿越到了火星由于引力不同，约翰成为了力大无穷、弹跳如飞的“超人”，也因此卷入当地几大族群的冲突，周旋于美丽的",
                                class = "美国 / 科幻",
                                rank = "No.5",
                                name = "异星战场",
                            },
                            {
                                trend = 0,
                                id = 641,
                                pic = "http://192.168.10.192/tu.php?tu=puui.qpic.cn/vcover_vt_pic/0/rj7m4uk4bvms4kht1463823184.jpg/220",
                                blurb = "在很久很久以前，中国的傣族地区曾有一个勐板扎国该国国王召庄香（陈强 饰）的儿子召树屯（唐国强 饰）英俊潇洒，骁勇善战，但是国王专横跋扈，子树屯没有丝毫自由，甚至婚事都要父王决定。达官贵人家的千金小姐虽",
                                class = "大陆 / 爱情",
                                rank = "No.6",
                                name = "孔雀公主",
                            },
                            {
                                trend = 0,
                                id = 123,
                                pic = "http://192.168.10.192/",
                                blurb = "",
                                class = "剧情",
                                rank = "No.7",
                                name = "胡桃夹子和四个王国",
                            },
                            {
                                trend = 0,
                                id = 879,
                                pic = "http://pic.tudou1238.com/upload/vod/2019-01-18/15477429240.jpg",
                                blurb = "熟女堂珍（闫妮 饰）还有另外一个名字—“夏百合”，曾经她用这个笔名创作了热门小说《落在胸口的星星》同时她也以“夏百合”的身份活跃在网游世界中，并与阳光大男孩小健（杜天皓 饰）相识，小健是作家“夏百合”",
                                class = "大陆 / 喜剧",
                                rank = "No.8",
                                name = "美容针",
                            },
                            {
                                trend = 0,
                                id = 900,
                                pic = "http://pic.tudou1238.com/![](http://ww1.sinaimg.cn/large/0061dRJogy1ff6bzod9d0j309h0dw75s.jpg)#err2019-01-17",
                                blurb = "The Archer Gang are back and doing a daring heist in London. Remanded in prison, they will try to br",
                                class = "英国 / 动作",
                                rank = "No.9",
                                name = "偷窃法则",
                            },
                            {
                                trend = 0,
                                id = 444,
                                pic = "http://192.168.10.192/tu.php?tu=puui.qpic.cn/vcover_vt_pic/0/kxv7onfg96lzwbgt1444905110.jpg/220",
                                blurb = "漂亮性感的都市剩女刘燕冰是一家影视公司的策划部主管，因为泼辣干练，雷厉风行，被同事们尊称为“灭绝师太”，个个敬而远之，而相恋多年的男友周乔也因为“红杏出墙”，被她打入冷宫。刘燕冰事业春风得意，爱情一家影视公司的策划部主管，因为泼辣干练，雷厉风行，被同事们尊称为“灭绝师太”，个个敬而远之，而相恋多年的男友周乔也因为“红杏出墙”，被她打入冷宫。刘燕冰事业春风得意，爱情\345\215却陷",
                                class = "大陆 / 爱情",
                                rank = "No.10",
                                name = "爱来不来",
                            },
                            ),
            },
            {
                type_id = 2,
                name = "电视剧",
                data =     (
                ),
            },
            {
                type_id = 4,
                name = "动漫",
                data =     (
                ),
            },
            {
                type_id = 3,
                name = "综艺",
                data =     (
                ),
            },
            ),
sign = "AC9D46A8E219FBADAC53943D51325F86",
token = "",
}
 */
