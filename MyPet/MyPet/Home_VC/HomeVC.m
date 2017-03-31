//
//  HomeVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatButton];
    
}

- (void)creatButton {
    
    if ([EMClient sharedClient].isLoggedIn) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(80, 300, 100, 50);
        button.backgroundColor = [UIColor cyanColor];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
    }else {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 300, 100, 50)];
        [self.view addSubview:label];
        label.text = @"用户未登录";
    
    }

    
    
}

-(void)logout {
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"退出登录"];
        loginVC *vc = [[loginVC alloc]init];
//        [self.navigationController pushViewController:vc animated:nil];
        [self presentViewController:vc animated:YES completion:nil];
    }
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
