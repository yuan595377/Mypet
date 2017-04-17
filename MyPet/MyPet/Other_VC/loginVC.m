//
//  loginVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/31.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "loginVC.h"
#import "ViewController.h"
@interface loginVC ()
@property (nonatomic, retain)UIButton *button_close;
@property (nonatomic, retain)UIImageView *imageAva;
@property (nonatomic, retain)UIButton *login;
@property (nonatomic, retain)UITextField *username;
@property (nonatomic, retain)UITextField *password;

@end

@implementation loginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageAva = [[UIImageView alloc]init];
    [self.view addSubview:_imageAva];
    
    [_imageAva mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 45);
        make.top.equalTo(self.view).with.offset(130);
    }];
    self.imageAva.layer.cornerRadius = 40;
    self.imageAva.layer.masksToBounds = YES;
    self.imageAva.layer.shadowColor = [UIColor yellowColor].CGColor;//shadowColor阴影颜色
    self.imageAva.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.imageAva.layer.shadowOpacity = 1;//阴影透明度，默认0
    self.imageAva.layer.shadowRadius = 3;//阴影半径，默认3
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    self.imageAva.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:fullPath]];
    
    
    
    
    self.username = [[UITextField alloc]init];
    [self.view addSubview:self.username];
    self.username.placeholder = @"手机号";
    self.username.layer.borderWidth = 0.8;
    self.username.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]);
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.imageAva.mas_bottom).with.offset(80);
    }];

    self.password = [[UITextField alloc]init];
    [self.view addSubview:self.password];
    self.password.placeholder = @"密码";
    [self.password setSecureTextEntry:YES];
    self.password.layer.borderWidth = 0.8;
    self.password.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]);
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.username.mas_bottom).with.offset(0);
    }];
    
    
    self.button_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_close];
    [self.button_close setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button_close setTitle:@"试用" forState:UIControlStateNormal];
    [self.button_close setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
    self.button_close.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(30);
    }];
    
    [self.button_close addTarget:self action:@selector(try) forControlEvents:UIControlEventTouchDown];
    
    
    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.login];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.login setTitle:@"登录" forState:UIControlStateNormal];
    [self.login setBackgroundImage:[UIImage imageNamed:@"login2.jpeg"] forState:UIControlStateNormal];
    self.login.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 100);
        make.top.equalTo(self.password.mas_bottom).with.offset(30);
    }];
    [self.login addTarget:self action:@selector(login2) forControlEvents:UIControlEventTouchDown];
    
    
}

- (void)try {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)login2 {

    EMError *error = [[EMClient sharedClient] loginWithUsername:self.username.text password:self.password.text];
    
    if (!error)
    {   [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[DLTabBarController alloc]init];
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
