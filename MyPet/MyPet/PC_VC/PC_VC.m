//
//  PC_VC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PC_VC.h"

@interface PC_VC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tabelOfPC;
@end

@implementation PC_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideNavi];
    [self createSubview];
}

- (void)hideNavi {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)createSubview {
    _tabelOfPC = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    


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
