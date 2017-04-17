//
//  RegisterVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/31.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "RegisterVC.h"
#import "RegisterVC_2.h"
@interface RegisterVC ()
@property (nonatomic, retain)UIButton *button_close;
@property (nonatomic, retain)UITextField *username;
@property (nonatomic, retain)UITextField *password;
@property (nonatomic, retain)UIButton *login;


@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatButton];
}



- (void)creatButton {
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
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.view.mas_top).with.offset(80);
    }];
    label.text = @"+86";
    
    self.username = [[UITextField alloc]init];
    [self.view addSubview:self.username];
    self.username.placeholder = @"输入手机号";
    self.username.layer.borderWidth = 0.8;
    self.username.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]);
    [self.username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(150);
        make.top.equalTo(self.view.mas_top).with.offset(80);
    }];
    
    self.password = [[UITextField alloc]init];
    [self.view addSubview:self.password];
    self.password.placeholder = @"设置登录密码，不少于6位";
    [self.password setSecureTextEntry:YES];
    self.password.layer.borderWidth = 0.8;
    self.password.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]);
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.username.mas_bottom).with.offset(0);
    }];

    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.login];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.login setTitle:@"下一步" forState:UIControlStateNormal];
    [self.login setBackgroundImage:[UIImage imageNamed:@"login2.jpeg"] forState:UIControlStateNormal];
    self.login.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 100);
        make.top.equalTo(self.password.mas_bottom).with.offset(30);
    }];
    [self.login addTarget:self action:@selector(register22) forControlEvents:UIControlEventTouchDown];

}


-(void)try {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void)register22 {
    
    RegisterVC_2 *vc = [[RegisterVC_2 alloc]init];
    vc.password = self.password.text;
    vc.userName = self.username.text;
    [self presentViewController:vc animated:YES completion:nil];

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
