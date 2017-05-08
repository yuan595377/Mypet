//
//  ViewController.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "ViewController.h"
#import "DLTabBarController.h"
@interface ViewController ()

@property (nonatomic, retain)UIImageView *image_logo;
@property (nonatomic, retain)UIButton *button_login;
@property (nonatomic, retain)UIButton *button_register;
@property (nonatomic, retain)UIButton *button_try;
@property (nonatomic, retain)UIButton *button_close;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViews];
}


- (void)setViews{
    //logo
    self.image_logo = [[UIImageView alloc]init];
    [self.view addSubview:self.image_logo];
    self.image_logo.image = [UIImage imageNamed:@"1logo.jpeg"];
    [self.image_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 40);
        make.top.equalTo(self.view.mas_top).with.offset(140);
    }];
    //login
    self.button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_login];
    [self.button_login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button_login.layer.borderWidth=1;//设置边框的宽度
    self.button_login.layer.cornerRadius = 18;
    self.button_login.layer.masksToBounds = YES;
    self.button_login.layer.borderColor=[[UIColor redColor]CGColor];
    [self.button_login setTitle:@"手机号登录" forState:UIControlStateNormal];
    [self.button_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.image_logo.mas_bottom).with.offset(60);
    }];
    [self.button_login addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchDown];
    
    //register
    self.button_register = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_register];
    [self.button_register setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button_register.layer.borderWidth=1;//设置边框的宽度
    self.button_register.layer.cornerRadius = 18;
    self.button_register.layer.masksToBounds = YES;
    self.button_register.layer.borderColor=[[UIColor redColor]CGColor];
    [self.button_register setTitle:@"注册" forState:UIControlStateNormal];
    [self.button_register mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.button_login.mas_bottom).with.offset(10);
    }];
    [self.button_register addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchDown];
    
    self.button_try = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_try];
    [self.button_try setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button_try setTitle:@"游客试用" forState:UIControlStateNormal];
    self.button_try.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button_try mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.button_register.mas_bottom).with.offset(5);
    }];
    [self.button_try addTarget:self action:@selector(try) forControlEvents:UIControlEventTouchDown];
    
    self.button_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_close];
    [self.button_close setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button_close setTitle:@"试用" forState:UIControlStateNormal];
    [self.button_close setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    self.button_close.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(30);
    }];
    [self.button_close addTarget:self action:@selector(try) forControlEvents:UIControlEventTouchDown];

}

- (void)loginUser{
    loginVC *vc = [[loginVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    


}

- (void)registerUser{
    
    RegisterVC *vc = [[RegisterVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];


}

- (void)try {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[DLTabBarController alloc]init];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
