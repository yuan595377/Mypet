//
//  Find_VC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/10.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "Find_VC.h"
#import "NewModel.h"
#import "detailVC.h"
@interface Find_VC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource;
@end

@implementation Find_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatSubViews];
    self.dataSource = [NSMutableArray array];
    [self fetchData];
}

- (void)creatSubViews{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    [self.tableView registerClass:[NewCell class] forCellReuseIdentifier:@"pool"];


}

- (void)fetchData {
    
  [APPTools GETWithURL:@"http://wp.asopeixun.com/left_category_data?category_id=225" par:nil success:^(id responseObject) {
      NSArray *list1 = [responseObject objectForKey:@"list"];
      [self.dataSource removeAllObjects];
      for (NSDictionary *dic in list1) {
          NSArray *list2 = [dic objectForKey:@"list"];
          for (NSDictionary *dic2 in list2) {
              NewModel *model = [[NewModel alloc]initWithDataSource:dic2];
              [self.dataSource addObject:model];
          }
      }
      [self.tableView reloadData];
      
  } filed:^(NSError *error) {
      
  }];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_dataSource) {
        
        return _dataSource.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"pool";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_dataSource) {
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource[indexPath.row];
        
        return cell;
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detailVC *vc = [[detailVC alloc]init];
    static NSString *identifier = @"pool";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.dataSource[indexPath.row];
    NSLog(@"model:%@,model_ID:%lu", cell.model,(unsigned long)cell.model.ID);
    vc.ID = cell.model.ID;
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
