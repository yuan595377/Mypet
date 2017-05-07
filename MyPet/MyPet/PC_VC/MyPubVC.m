//
//  MyPubVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "MyPubVC.h"

@interface MyPubVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource1;

@end

@implementation MyPubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTable];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchData];
    
}


- (void)createTable {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[CellOfMyPub class] forCellReuseIdentifier:@"pool"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchData {
    self.dataSource1 = [NSMutableArray array];
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:STOREAGE_INFO];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    //返回最多20个结果
    query.limit = 20;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //处理查询结果
        for (BmobObject *obj in array) {
            PubModel * info  = [[PubModel alloc] init];
            if ([[obj objectForKey:@"user_id"] isEqualToString:[EMClient sharedClient].currentUsername]) {
                NSString *a    = [obj objectForKey:@"objectId"];
                NSLog(@"id发的内容为:%@, title:%@,发表时间:%@", a, [obj objectForKey:@"title"],[obj objectForKey:@"createdAt"]);
                info.title = [obj objectForKey:@"title"];
                NSLog(@"info:%@", info.title);
            }
            
            if (info.title) {
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
    CellOfMyPub *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    
    if (_dataSource1) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource1[indexPath.row];
        
        return cell;
        
    }
    return cell;
    
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
