//
//  CHVersionDetection.h
//  检测版本更新
//
//  Created by 张晨晖 on 2018/3/20.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, ZCHAppserverType) {//检测什么端口的应用是否有新版本
//    ZCHAppserverTypeAppStore,//检测AppStore上是否有更新
//    ZCHAppserverTypeServer,//服务器
//};

/**
 检测新版本的Block

 @param hasNewVersion 是否有新的版本
 @param infoDic 一些更新信息
 @param trackViewUrl 商店地址
 @param version 版本号
 @param releaseNotes 本次更新内容
 */
typedef void(^CHVersionDetectionBlock)(BOOL hasNewVersion ,NSDictionary *infoDic ,NSURL *trackViewUrl ,NSString *version ,NSString *releaseNotes);

@interface CHVersionDetection : NSObject

+ (void)versionDetctionWithAppIDString:(NSString *)appID andresultBlock:(CHVersionDetectionBlock) block;

@end
