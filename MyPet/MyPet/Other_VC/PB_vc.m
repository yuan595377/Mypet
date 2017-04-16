//
//  PB_vc.m
//  MyPet
//
//  Created by 袁立康 on 17/4/16.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PB_vc.h"

@interface PB_vc ()<UITextViewDelegate>
@property (nonatomic, retain)UIButton *button_login;
@property (nonatomic, retain)UITextView *textView;
@end

@implementation PB_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height - 300) textContainer:nil];

    [self.view addSubview:self.textView];
    self.textView.delegate = self;
    
    //login
    self.button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_login];
    [self.button_login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button_login.layer.borderWidth=1;//设置边框的宽度
    self.button_login.layer.cornerRadius = 18;
    self.button_login.layer.masksToBounds = YES;
    self.button_login.layer.borderColor=[[UIColor redColor]CGColor];
    [self.button_login setTitle:@"发送" forState:UIControlStateNormal];
    [self.button_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, 40));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(_textView.mas_bottom).with.offset(60);
    }];
    [self.button_login addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchDown];
}

- (void)loginUser {
    //创建BmobObject对象，指定对应要操作的数据表名称
    BmobObject *obj = [[BmobObject alloc] initWithClassName:[EMClient sharedClient].currentUsername];
    //设置字段值
    [obj setObject:_textView.text forKey:@"title"];
    //执行保存操作
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            //其他代码
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];

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
