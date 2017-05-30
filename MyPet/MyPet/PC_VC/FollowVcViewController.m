//
//  FollowVcViewController.m
//  MyPet
//
//  Created by 袁立康 on 17/5/28.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "FollowVcViewController.h"
#import "followModel.h"
#import "FollowCell.h"
@interface FollowVcViewController ()<UITableViewDelegate, UITableViewDataSource>;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *arr;
@end

@implementation FollowVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchData];
    [self creatTableView];
}


- (void)creatTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[FollowCell class] forCellReuseIdentifier:@"pool"];


}

- (void)fetchData {

    _arr = [NSMutableArray array];
    BmobUser *user = [BmobUser currentUser];
    NSArray *a = [user objectForKey:@"follow_list"];
    NSLog(@"aaaa:%@, user%@", a,user);
    for (NSString *str in a) {
        followModel *model = [[followModel alloc]init];
        model.username = str;
        [_arr addObject:model];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.arr[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.model = self.arr[indexPath.row];
   
    EaseMessageViewController *vc = [[EaseMessageViewController alloc]initWithConversationChatter:cell.username.text conversationType:EMConversationTypeChat];
    vc.userId = cell.username.text;
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
