//
//  CustomActivity.m
//  UIActivityViewController
//
//  Created by zhudong on 2017/8/16.
//  Copyright © 2017年 zhudong. All rights reserved.
//

#import "CustomActivity.h"
#import "WeiXinController.h"

NSString *const CustomActivityMine = @"CustomActivityMine";

@interface CustomActivity ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) NSArray *items_toShare;
@property (nonatomic, strong) UINavigationController *nav;
@end

@implementation CustomActivity

- (instancetype)initWithTitie:(NSString *)title withImageName:(NSString *)imageName{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
    }
    return self;
}
- (UIViewController *)activityViewController{
    
    UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeiXinController *weixinC = [storyB instantiateViewControllerWithIdentifier:@"WeiXinController"];
    weixinC.items_toShare = self.items_toShare;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:weixinC];
    weixinC.title = @"微信";
    weixinC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(complete)];
    self.nav = nav;
    return nav;
}

- (void)complete {
    
    [self.nav dismissViewControllerAnimated:true completion:^{
        NSLog(@"完成发布");
    }];
}

- (UIActivityType)activityType{
    
    return CustomActivityMine;
}

- (NSString *)activityTitle{
    return self.title;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems{
    
    NSLog(@"%@", activityItems);
    
    return true;
}
- (void)prepareWithActivityItems:(NSArray *)activityItems{
    self.items_toShare = activityItems;
    NSLog(@"%@", activityItems);
}

- (void)performActivity{
    NSLog(@"performActivity");
}

- (void)activityDidFinish:(BOOL)completed{
    NSLog(@"activityDidFinish");
}

- (UIImage *)activityImage{
    return [UIImage imageNamed:self.imageName];
}

+ (UIActivityCategory)activityCategory{
    return UIActivityCategoryShare;
}

@end
