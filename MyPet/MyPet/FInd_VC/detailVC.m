//
//  detailVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/11.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "detailVC.h"

@interface detailVC ()<UIWebViewDelegate>

@end

@implementation detailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *view = [[UIWebView alloc]initWithFrame:self.view.frame];
    view.delegate = self;
    NSString *url = [NSString stringWithFormat:@"http://wp.asopeixun.com/?p=%ld", (long)self.ID];
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('box')[0].style.display = 'NONE'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomAD')[0].style.display = 'NONE'"];
    
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
