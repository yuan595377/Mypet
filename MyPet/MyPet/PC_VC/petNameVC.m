//
//  petNameVC.m
//  MyPet
//
//  Created by 袁立康 on 17/5/30.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "petNameVC.h"

@interface petNameVC ()<UITextViewDelegate>
@property (nonatomic, retain)UITextView *textView;

@end

@implementation petNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.title = @"宠物名称";
    [self setSubView];
}

- (void)setSubView {

    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 48) textContainer:nil];
    _textView.textColor = [UIColor blueColor];
    _textView.font = [UIFont systemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.opaque = YES;
    _textView.alpha = 1.0;
    _textView.delegate = self;
    //    _textView.tag = VALUE_LABEL_TAG;
    _textView.clipsToBounds = YES;
    //    _textView.text = self.chatBody;
    _textView.textAlignment = UITextAlignmentLeft;
    _textView.editable = YES;
    _textView.scrollEnabled = YES;
    [_textView becomeFirstResponder];
    [self.view addSubview: _textView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightItem;
    

}

- (void)save {
    
    BmobUser *user = [BmobUser currentUser];
    [user setObject:self.textView.text forKey:@"petName"];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (!error) {
            NSLog(@"保存成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            NSLog(@"%@", error);
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
