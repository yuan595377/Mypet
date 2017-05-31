//
//  DLTabBarController.m
//  DLTabBarControllerDemo
//
//  Created by FT_David on 16/5/27.
//  Copyright © 2016年 FT_David. All rights reserved.
//

#import "DLTabBarController.h"
#import "ViewController.h"
#import "DLTabBar.h"
#import "BHBPopView.h"
@interface DLTabBarController ()

@end

@implementation DLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewControllers];
    [self setupTabbar];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0.19 green:0.21 blue:0.23 alpha:1.00]];;
   
}


-(void)setupViewControllers
{
    // 1.初始化子控制器
    HomeVC *home = [[HomeVC alloc] init];
    [self addChildVc:home title:@"社区" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    EaseConversationListViewController *messageCenter = [[EaseConversationListViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    Find_VC *discover = [[Find_VC alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    PcVC *profile = [[PcVC alloc] init];
    [self addChildVc:profile title:@"个人中心" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

-(void)setupTabbar
{
   
    DLTabBar *tabBar = [[DLTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

#pragma mark - DLTabBarDelegate
-(void)tabBarDidClickAtCenterButton:(DLTabBar *)tabBar
{
    
    if (![EMClient sharedClient].isLoggedIn) {
        [SVProgressHUD showErrorWithStatus:@"请先登录"];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        
        return;
    }
       PB_vc *vc = [[PB_vc alloc]init];
       [self presentViewController:vc animated:YES completion:^{
           
       }];
    
}


- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [nav.navigationBar NightWithType:UIViewColorTypeNormal];
    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:1.00 green:0.53 blue:0.49 alpha:1.00]];
    [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];


    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}





@end
