//
//  setVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/6.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "setVC.h"
#import "ViewController.h"
@interface setVC ()<LEActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@end

@implementation setVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setSubView];
}


- (void)setSubView {
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 44;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];



}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 3;
    }else {
        return 1;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    long section = indexPath.section;
    long row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (section) {
        case 0:
            if(row == 0)
            {
                cell.textLabel.text =  @"头像";
            
            }else{
                cell.textLabel.text =  @"昵称";
            }
            break;
        case 1:
            if(row == 0)
            {
                cell.textLabel.text =  @"夜间模式";
            }else if(row == 1){
                cell.textLabel.text =  @"意见反馈";
            }else {
              cell.textLabel.text =  @"评分";
            }
            break;
        case 2:
            cell.textLabel.text =  @"退出登录";
            break;
            default:
            break;
}


    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    long section = indexPath.section;
    long row = indexPath.row;
    switch (section) {
        case 0:
            if(row == 0)
            {
                AvatarVC *vc = [[AvatarVC alloc]init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                [SVProgressHUD showSuccessWithStatus:@"昵称"];
            }
            break;
        case 1:
            if(row == 0)
            {
                [SVProgressHUD showSuccessWithStatus:@""];
            }else if(row == 1){
                [SVProgressHUD showSuccessWithStatus:@""];
            }else {
                [SVProgressHUD showSuccessWithStatus:@""];
            }
            break;
        case 2:
                [self logOut];
            break;
        default:
            break;


}
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut {
    LEActionSheet *actionSheet = [[LEActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据,下次登录依然可以使用本账号"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"退出登录"
                                                    otherButtonTitles:nil];
    [actionSheet showInView:self.view.window];
}

-(void)actionSheet:(LEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self logout];
    }
}


- (void)logout {
    
  [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
      [self dismissViewControllerAnimated:YES completion:nil];
      [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc]init];
      
  }];
    

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
