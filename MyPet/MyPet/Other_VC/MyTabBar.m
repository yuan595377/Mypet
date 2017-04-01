//
//  MyTabBarController.m
//  Graduation Design-A
//
//  Created by 袁立康 on 17/3/17.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()

@end

@implementation MyTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildViewController];
}

- (void)setUpAllChildViewController{
    // 1.添加第一个控制器
    HomeVC *oneVC = [[HomeVC alloc]init];
    UIImage * homenormalImage = [[UIImage imageNamed:@"home_line-2.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * homeselectImage = [[UIImage imageNamed:@"home_shape-2.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setUpOneChildViewController:oneVC image:homenormalImage select_img:homeselectImage title:@"首页"];
    
    // 2.添加第2个控制器

    PublishVC *twoVC = [[PublishVC alloc]init];
    UIImage * publishImg = [[UIImage imageNamed:@"publish.png"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self setUpOneChildViewController:twoVC image:publishImg select_img:nil title:@"发布"];
    
    // 3.添加第3个控制器
    conversationListVc *conversation = [[conversationListVc alloc]init];
    [self setUpOneChildViewController:conversation image:nil select_img:nil title:@"消息"];
    // 4.添加第4个控制器
    PC_VC *Pc_VC = [[PC_VC alloc]init];
    [self setUpOneChildViewController:Pc_VC image:nil select_img:nil title:@"我的"];
    
}

- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image select_img:(UIImage *)select_img title:(NSString *)title{
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = select_img;
    [navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    [self addChildViewController:navC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
