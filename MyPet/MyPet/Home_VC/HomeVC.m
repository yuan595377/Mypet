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
    [self createTable];
   
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchData];
    
}


- (void)createTable {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 200;
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
            InfoModel *info    = [[InfoModel alloc] init];
            if ([obj objectForKey:@"title"]) {
                info.title    = [obj objectForKey:@"title"];
                info.name = [obj objectForKey:@"user_id"];
                NSLog(@"%@", info.title);
            }
            [self.dataSource1 addObject:info];
        }
        
        
        [_tableView reloadData];
    }];

    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"%@", _dataSource1);
    return _dataSource1.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellOfInfo *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    
    if (_dataSource1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource1[indexPath.row];
        [cell.contact addTarget:self action:@selector(contact1:) forControlEvents:UIControlEventTouchDown];
        [cell.contact setTitle:cell.name.text forState:UIControlStateNormal];
        


        
        return cell;
        
    }
    return cell;
}



- (void)contact1:(UIButton *)button {
    NSLog(@"button_title:%@, nameId:%@", button.currentTitle, self.nameId);
    if ([button.currentTitle isEqualToString:[EMClient sharedClient].currentUsername]) {
        [SVProgressHUD showErrorWithStatus:@"不可以和自己聊天哦"];
        
    }else {
        chatVC *vc = [[chatVC alloc]initWithConversationChatter:button.currentTitle conversationType:EMConversationTypeChat];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
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
