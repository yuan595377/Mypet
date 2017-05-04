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
@property (nonatomic, retain)UIButton *button_close;
@end

@implementation PB_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height - 300) textContainer:nil];
    _textView.textColor = [UIColor blueColor];
    _textView.font = [UIFont systemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.opaque = YES;
    _textView.alpha = 1.0;
    _textView.delegate = self;
//    _textView.tag = VALUE_LABEL_TAG;
    _textView.layer.cornerRadius = 8;
    _textView.clipsToBounds = YES;
//    _textView.text = self.chatBody;
    _textView.textAlignment = UITextAlignmentLeft;
    _textView.editable = YES;
    _textView.scrollEnabled = YES;
    [_textView becomeFirstResponder];
    [self.view addSubview: _textView];
    
    //login
    self.button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_login];
    [self.button_login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button_login.layer.borderWidth=1;//设置边框的宽度
    self.button_login.layer.cornerRadius = 8;
    self.button_login.layer.masksToBounds = YES;
    self.button_login.layer.borderColor=[[UIColor redColor]CGColor];
    [self.button_login setTitle:@"发送" forState:UIControlStateNormal];
    [self.button_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.view.mas_top).with.offset(30);
    }];
    [self.button_login addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchDown];
    
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
    
    
    
}

- (void)try {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)loginUser {
    //创建BmobObject对象，指定对应要操作的数据表名称
    BmobObject *obj = [[BmobObject alloc] initWithClassName:STOREAGE_INFO];
    //设置字段值
    [obj setObject:_textView.text forKey:@"title"];
    [obj setObject:[EMClient sharedClient].currentUsername forKey:@"user_id"];
    //执行保存操作
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            //其他代码
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[DLTabBarController alloc]init];
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
