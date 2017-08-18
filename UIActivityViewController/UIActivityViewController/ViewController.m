//
//  ViewController.m
//  UIActivityViewController
//
//  Created by zhudong on 2017/8/16.
//  Copyright © 2017年 zhudong. All rights reserved.
//

#import "ViewController.h"
#import "CustomActivity.h"

@interface ViewController ()

@end

@implementation ViewController

#define ScreenSize [UIScreen mainScreen].bounds.size
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat leftMargin = 30;
    CGFloat btnW = ScreenSize.width - 2 * leftMargin;
    btn.frame = CGRectMake(leftMargin, 100, btnW, 40);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


- (void)share {
    //@"我是冬风破10_IOS，欢迎关注我"
    NSString *title = @"微信";
    NSString *imageName = @"weixin";
    
    CustomActivity * custom = [[CustomActivity alloc] initWithTitie:title withImageName:imageName];

    NSArray *activities = @[custom];
    
    NSString *text = @"这一刻的想法...";
    UIImage *image = [UIImage imageNamed:@"weixin"];
    NSString *subTitle = @"摇一摇, 打开未知世界. ";
    
    NSArray *items = @[text, image, subTitle];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:activities];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        activityVC.completionHandler = ^(UIActivityType  _Nullable activityType, BOOL completed) {
            NSLog(@"completionHandler");
        };
    }else{
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            NSLog(@"completionWithItemsHandler");
        };
    }
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                         
                                         UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:true completion:nil];
}

@end
