//
//  setVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/6.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "setVC.h"
@interface setVC ()<LEActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@end

@implementation setVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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

    return 2;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
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
                cell.textLabel.text =  @"夜间模式";
            }else if(row == 1){
                cell.textLabel.text =  @"清除缓存";
            }else {
                cell.textLabel.text =  @"评分";
            }
            break;
        case 1:
            if (![EMClient sharedClient].isLoggedIn) {
                cell.hidden = YES;
                
            }else {
                cell.accessoryType = UITableViewCellStyleDefault;
                cell.textLabel.text =  @"退出登录";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
            
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
                [ThemeManage shareThemeManage].isNight = ![ThemeManage shareThemeManage].isNight;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
                [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"night"];
            }else if(row == 1){
                [SVProgressHUD showSuccessWithStatus:@"已清除缓存"];
            }else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/nico%E6%98%B5%E5%AE%A0/id1227545531?mt=8"]];
            }
            break;

        case 1:
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
