//
//  ProcoVC.m
//  MyPet
//
//  Created by 袁立康 on 17/5/7.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "ProcoVC.h"

@interface ProcoVC ()<UIWebViewDelegate>
@property (nonatomic, retain)UIWebView *webView;
@property (nonatomic, retain)UIButton *button_close;
@end

@implementation ProcoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 30)];
    self.webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webView.detectsPhoneNumbers = YES;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"http://opl84kdv6.bkt.clouddn.com/test.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
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


- (void)webViewDidStartLoad:(UIWebView *)webView {

    
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
