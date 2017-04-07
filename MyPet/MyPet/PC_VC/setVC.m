//
//  setVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/6.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "setVC.h"

@interface setVC ()<LEActionSheetDelegate>

@end

@implementation setVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
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
      loginVC *vc = [[loginVC alloc]init];
      [self.navigationController pushViewController:vc animated:YES];
      
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
