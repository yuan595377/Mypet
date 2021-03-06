//
//  HomeVC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "HomeVC.h"
@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource1;
@property (nonatomic, retain)NSString *nameId;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self fetchData];
    [self createTable];

    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}


- (void)createTable {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 450;
    [self.tableView registerClass:[CellOfInfo class] forCellReuseIdentifier:@"pool"];

}

- (void)fetchData {
    
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:STOREAGE_INFO];
    self.dataSource1 = [NSMutableArray array];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    //返回最多20个结果
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //处理查询结果
        for (BmobObject *obj in array) {
            if ([obj objectForKey:@"title"]) {
                InfoModel *info    = [[InfoModel alloc] init];
                info.title    = [obj objectForKey:@"title"];
                info.name = [obj objectForKey:@"user_id"];
                info.time = [obj objectForKey:@"Pub_time"];
                info.url = [obj objectForKey:@"PubImg"];
                info.avatarUrl = [obj objectForKey:@"user_avatar"];
                if ([[NSString stringWithFormat:@"%@", [obj objectForKey:@"is_close"]] isEqualToString:@"1"]) {
                    info.is_close = @"已接单";
                }else {
                    info.is_close = @"";
                
                }
                [self.dataSource1 addObject:info];
    
            }
            
            
        }
        [_tableView reloadData];
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"pool";
    CellOfInfo *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (_dataSource1) {
        cell.model = [self.dataSource1 objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contact addTarget:self action:@selector(contact1:) forControlEvents:UIControlEventTouchDown];
        [cell.contact setTitle:cell.name.text forState:UIControlStateNormal];
        [cell.follow addTarget:self action:@selector(follow_me:) forControlEvents:UIControlEventTouchDown];
        return cell;
        
    }

        return cell;

}



- (void)contact1:(UIButton *)button {
    
    if (![EMClient sharedClient].isLoggedIn) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc]init];
        return;
    }
    
    if ([button.currentTitle isEqualToString:[EMClient sharedClient].currentUsername]) {
        [SVProgressHUD showErrorWithStatus:@"不可以和自己聊天哦"];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        
    }else {
        EaseMessageViewController *vc = [[EaseMessageViewController alloc]initWithConversationChatter:button.currentTitle conversationType:EMConversationTypeChat];
        vc.userId = button.currentTitle;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)follow_me:(UIButton *)button {
    
    [SVProgressHUD showSuccessWithStatus:@"举报成功"];
    [SVProgressHUD setMinimumDismissTimeInterval:1];

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
