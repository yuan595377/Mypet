//
//  loginVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/31.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "loginVC.h"

@interface loginVC ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)login:(id)sender {
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.username.text password:self.password.text];
    
    if (!error)
    {   [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)register:(id)sender {
    
    
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
