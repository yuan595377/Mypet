//
//  NewPC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/20.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "NewPC.h"

@interface NewPC ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *dec;

@property (weak, nonatomic) IBOutlet UIButton *action;

@property (weak, nonatomic) IBOutlet UIButton *follow;
@property (weak, nonatomic) IBOutlet UIButton *fans;

@property (weak, nonatomic) IBOutlet UIButton *mymsg;


@property (weak, nonatomic) IBOutlet UIButton *mypet;

@property (weak, nonatomic) IBOutlet UIButton *mycode;
@property (weak, nonatomic) IBOutlet UIButton *catch;
@property (weak, nonatomic) IBOutlet UIButton *settingbutton;


@end

@implementation NewPC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatSubview];
}

- (void)creatSubview {
    
    self.name.text = [EMClient sharedClient].currentUsername;
    
    
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 35;
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(10);
    }];
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [self.view addSubview:view2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 10));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.mymsg.mas_bottom).with.offset(3);
    }];
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [self.view addSubview:view3];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 10));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.mypet.mas_bottom).with.offset(8);
    }];
    
    UIView *view4 = [[UIView alloc]init];
    view4.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [self.view addSubview:view4];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 1));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.mycode.mas_bottom).with.offset(10);
    }];
    
    UIView *view5 = [[UIView alloc]init];
    view5.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [self.view addSubview:view5];
    
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 50, 1));
        make.left.equalTo(self.view).with.offset(50);
        make.top.equalTo(self.catch.mas_bottom).with.offset(10);
    }];
    

}
- (IBAction)set:(id)sender {
    setVC *vc = [[setVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)ToMyCode:(id)sender {
    MyCodeVC *vc = [[MyCodeVC alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)scan:(id)sender {
    
    ScanVc *vc = [[ScanVc alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
    
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
