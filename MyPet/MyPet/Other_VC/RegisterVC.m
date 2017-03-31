//
//  RegisterVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/31.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatButton];
}



- (void)creatButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(80, 300, 100, 50);
    button.backgroundColor = [UIColor cyanColor];
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(registerq) forControlEvents:UIControlEventTouchDown];


}

- (void)registerq {
    NSLog(@"点击注册");
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userName.text password:self.password.text];
    
    if (error==nil) {
        NSLog(@"环信注册成功");
        //注册成功后立即登录
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userName.text password:self.password.text];
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            NSTimeInterval time = 1;
            [SVProgressHUD dismissWithDelay:time];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }else {
        NSLog(@"注册失败:%@", error.description);
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
