//
//  ViewController.m
//  检测版本更新
//
//  Created by 张晨晖 on 2018/3/20.
//  Copyright © 2018年 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "ZCHVersionDetection.h"
#import <StoreKit/StoreKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ZCHVersionDetection versionDetctionWithAppIDString:@"1262247888" andresultBlock:^(BOOL hasNewVersion, NSDictionary *infoDic, NSURL *trackViewUrl, NSString *version, NSString *releaseNotes) {
        NSLog(@"%@",hasNewVersion == YES? @"有新版本":@"没有新版本");
        NSLog(@"infoDic:%@",infoDic);
        NSLog(@"Store下载地址:%@",trackViewUrl);
        NSLog(@"Store上版本号:%@",version);
        NSLog(@"Store更新内容:%@",releaseNotes);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"最新版本:%@",version] message:[NSString stringWithFormat:@"更新内容:%@",releaseNotes] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"暂时不更新" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //jump to AppStore
            //1.jump
            [[UIApplication sharedApplication] openURL:trackViewUrl];

            ////
//            //2.modal
//            SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
//            storeViewController.delegate = self;
//            NSDictionary *parametersDic = @{SKStoreProductParameterITunesItemIdentifier:[userDefault objectForKey:TRACK_ID]};
//            [storeViewController loadProductWithParameters:parametersDic completionBlock:^(BOOL result, NSError * _Nullable error) {
//
//                if (result) {
//                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeViewController animated:YES completion:^{
//
//                    }];
//                }
//            }];
            ////

        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
