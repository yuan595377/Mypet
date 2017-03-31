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
    [self creatButton];
    
}


- (void)creatButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(80, 300, 100, 50);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
    
    
}

-(void)logout {
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"退出登录"];
        RegisterVC *vc = [[RegisterVC alloc]init];
        [self.navigationController pushViewController:vc animated:nil];
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
