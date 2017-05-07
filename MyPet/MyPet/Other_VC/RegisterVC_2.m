//
//  RegisterVC_2.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "RegisterVC_2.h"

@interface RegisterVC_2 ()
@property (nonatomic, retain)UIButton *button_close;
@property (nonatomic, retain)UITextField *username2;
@property (nonatomic, retain)UIButton *login;
@property (nonatomic, retain)UIButton *send;
@property (nonatomic, retain)UIButton *choose;
@property (nonatomic, retain)UIButton *procol;
@property (nonatomic, retain)UILabel *labelOfdec;


@end

@implementation RegisterVC_2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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
    label.text = @"为了安全，我们会向您的手机发送验证码";
    [self.view addSubview:label];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setTextColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 30));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.view).with.offset(60);
    }];
    
    self.username2 = [[UITextField alloc]init];
    [self.view addSubview:self.username2];
    self.username2.placeholder = @"输入验证码";
    self.username2.layer.borderWidth = 0.8;
    self.username2.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00]);
    [self.username2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 230, 40));
        make.left.equalTo(self.view).with.offset(90);
        make.top.equalTo(label.mas_bottom).with.offset(40);
    }];
    
    self.send = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.send];
//    self.send.backgroundColor = [UIColor redColor];
    [self.send setTitleColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.85 alpha:1.00] forState:UIControlStateNormal];
    [self.send setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.send.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.left.equalTo(self.username2.mas_right).with.offset(10);
        make.top.equalTo(label.mas_bottom).with.offset(40);
    }];
    [self.send addTarget:self action:@selector(send2) forControlEvents:UIControlEventTouchDown];
    
    
    self.login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.login];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.login setTitle:@"注册" forState:UIControlStateNormal];
    [self.login setBackgroundImage:[UIImage imageNamed:@"login2.jpeg"] forState:UIControlStateNormal];
    self.login.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 100);
        make.top.equalTo(self.username2.mas_bottom).with.offset(30);
    }];
    [self.login addTarget:self action:@selector(registerq) forControlEvents:UIControlEventTouchDown];

    self.choose = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.choose];
    [self.choose setImage:[UIImage imageNamed:@"对勾.png"] forState:UIControlStateNormal];
    [self.choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.login.mas_bottom).with.offset(30);
    }];
    self.choose.tag = 1;
    [self.choose addTarget:self action:@selector(chooseimg:) forControlEvents:UIControlEventTouchDown];
    
    self.labelOfdec = [[UILabel alloc]init];
    [self.view addSubview:self.labelOfdec];
    self.labelOfdec.text = @"注册代表您已同意";
    [self.labelOfdec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.left.equalTo(self.choose.mas_right).with.offset(5);
        make.top.equalTo(self.login.mas_bottom).with.offset(30);
        
        
    }];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"昵宠用户协议"];
    NSRange strRange = {0, [str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    self.procol = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.procol setAttributedTitle:str forState:UIControlStateNormal];
    
    [self.view addSubview:self.procol];
    [self.procol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.left.equalTo(self.labelOfdec.mas_right).with.offset(5);
        make.top.equalTo(self.login.mas_bottom).with.offset(30);
    }];
    [self.procol addTarget:self action:@selector(jumpTopro) forControlEvents:UIControlEventTouchDown];
    
}

- (void)chooseimg:(UIButton *)button {
    if (button.tag == 1) {
        button.tag = 0;
        [self.choose setImage:[UIImage imageNamed:@"圆.png"] forState:UIControlStateNormal];
    }else {
        button.tag = 1;
        [self.choose setImage:[UIImage imageNamed:@"对勾.png"] forState:UIControlStateNormal];
        
        
    }
    
}

- (void)jumpTopro {
    
    ProcoVC *vc = [[ProcoVC alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
    
}


- (void)try {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send2 {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userName zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        }else{
            NSLog(@"%@", error);
            
        }
        
    }];

 

}


- (void)registerq {
    NSLog(@"点击注册");
    
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.userName password:self.password];
    
    if (error==nil) {
        NSLog(@"环信注册成功");
        //注册成功后立即登录
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.userName password:self.password];
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            NSTimeInterval time = 1;
            [SVProgressHUD dismissWithDelay:time];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[DLTabBarController alloc]init];
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
