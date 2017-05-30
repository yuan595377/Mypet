//
//  MyPubVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/18.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "MyPubVC.h"
#import "Mybutton.h"
@interface MyPubVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource1;
@property (nonatomic, retain)UILabel *placeholderImg;

@end

@implementation MyPubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource1 = [NSMutableArray array];
    [self fetchData];
    [self createTable];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}


- (void)createTable {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 300;
    [self.tableView registerClass:[CellOfMyPub class] forCellReuseIdentifier:@"pool"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchData {
    
    //创建BmobQuery实例，指定对应要操作的数据表名称
    BmobQuery *query = [BmobQuery queryWithClassName:STOREAGE_INFO];
    //按updatedAt进行降序排列
    [query orderByDescending:@"updatedAt"];
    //返回最多20个结果
    query.limit = 50;
    //执行查询
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //处理查询结果
        for (BmobObject *obj in array) {
            PubModel * info  = [[PubModel alloc] init];
            if ([[obj objectForKey:@"user_id"] isEqualToString:[EMClient sharedClient].currentUsername]) {
                
                info.objectID = [obj objectForKey:@"objectId"];
                info.title = [obj objectForKey:@"title"];
                info.url = [obj objectForKey:@"PubImg"];
                info.closenum = [NSNumber numberWithInteger:[NSString stringWithFormat:@"%@",[obj objectForKey:@"is_close"]].integerValue];
                
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
        cell.bu.object_ID = cell.objectID;
        [cell.bu addTarget:self action:@selector(jum:) forControlEvents:UIControlEventTouchDown];
        return cell;
        
    }
    return cell;
    
}


- (void)jum:(Mybutton *)bt {
    
    if ([bt.currentTitle isEqualToString:@"关闭接单"]) {
        
        [bt setTitle:@"已接单" forState:UIControlStateNormal];
    }
    
    BmobObjectsBatch *batch = [[BmobObjectsBatch alloc] init] ;
    [batch updateBmobObjectWithClassName:STOREAGE_INFO objectId:bt.object_ID parameters:@{@"is_close":@1}];
    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"关闭接单"];
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
