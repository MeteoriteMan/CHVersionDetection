//
//  CHVersionDetection.m
//  检测版本更新
//
//  Created by 张晨晖 on 2018/3/20.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "CHVersionDetection.h"

@interface CHVersionDetection()

@property (nonatomic ,strong) NSString *appID;

@property (nonatomic ,strong) NSDictionary *resultsDic;

@property (nonatomic ,copy) CHVersionDetectionBlock versionDetectionBlock;

@end

@implementation CHVersionDetection

+ (void)versionDetctionWithAppIDString:(NSString *)appID andresultBlock:(CHVersionDetectionBlock)block {
    CHVersionDetection *versionDetection = [[CHVersionDetection alloc] init];
    versionDetection.appID = appID;
    versionDetection.versionDetectionBlock = block;
    [versionDetection getInfo];
}

- (NSString *)appID {
    if (!_appID) {//使用QQ的APPID来占位:"444934666"
        _appID = @"444934666";
    }
    return _appID;
}

//获取线上版本号
- (void)getInfo {
    NSString *urlStr = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",self.appID];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //网络请求
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {//如果没有数据
                return;
            }
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (!([[dataDic objectForKey:@"resultCount"] intValue] > 0)) {//不是@"1"
                return;
            }
            NSArray *array = [dataDic objectForKey:@"results"];
            _resultsDic = array[0];
            dispatch_sync(dispatch_get_main_queue(), ^{
                //回调.回到主线程
                NSString *urlString = [_resultsDic objectForKey:@"trackViewUrl"];
                if ([self compareVersion:[_resultsDic objectForKey:@"version"]] == YES) {
                    if (_versionDetectionBlock) {
                        _versionDetectionBlock(YES, _resultsDic, [NSURL URLWithString:urlString], [_resultsDic objectForKey:@"version"], [_resultsDic objectForKey:@"releaseNotes"]);
                    }
                } else {
//                    if (_versionDetectionBlock) {
//                        _versionDetectionBlock(NO, _resultsDic, [NSURL URLWithString:urlString], [_resultsDic objectForKey:@"version"], [_resultsDic objectForKey:@"releaseNotes"]);
//                    }
                }
            });
        }] resume];
    });
}

- (BOOL)compareVersion:(NSString *)serverVersion {
    /*
     * typedef NS_ENUM(NSInteger, NSComparisonResult) {
     *    NSOrderedAscending = -1L,//升序
     *    NSOrderedSame,//等于
     *    NSOrderedDescending  //降序
     * };
     */
    //比较当前版本和新版本号的大小
    if ([[self getLocalAppVersion] compare:serverVersion options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

//获取当前APP的版本号
- (NSString *)getLocalAppVersion {
    //获取应用当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}

@end
