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
@interface Find_VC ()<UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource;
@end

@implementation Find_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatSubViews];
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
   self.dataSource = [NSMutableArray array];
  [APPTools GETWithURL:@"http://wp.asopeixun.com/left_category_data?category_id=225" par:nil success:^(id responseObject) {
      NSArray *list1 = [responseObject objectForKey:@"list"];
      for (NSDictionary *dic in list1) {
          NSArray *list2 = [dic objectForKey:@"list"];
          for (NSDictionary *dic2 in list2) {
              NewModel *model = [[NewModel alloc]init];
              model.title = [dic2 objectForKey:@"title"];
              model.edittime = [dic2 objectForKey:@"edittime"];
              model.thumb = [dic2 objectForKey:@"thumb"];
              model.ID = [NSString stringWithFormat:@"%@", [dic2 objectForKey:@"ID"]].integerValue;
              [self.dataSource addObject:model];
          }
      }
      [self.tableView reloadData];
      
  } filed:^(NSError *error) {
      
  }];


}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"dataSource:%lu", (unsigned long)_dataSource.count);
    if (_dataSource) {
        
        return _dataSource.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"pool";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    if (_dataSource) {
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataSource[indexPath.row];
        NSLog(@"id:%ld", (long)cell.IDD);
        
        return cell;
        
    }
    return cell;
}

- (nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    //浅按
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    NewModel *model = [[NewModel alloc]init];
    model = self.dataSource[indexPath.row];
    detailVC *vc = [[detailVC alloc]init];
    vc.ID = model.ID;
    return vc;
}


- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    
    NewModel *model = [[NewModel alloc]init];
    model = self.dataSource[indexPath.row];
    detailVC *vc = [[detailVC alloc]init];
    vc.ID = model.ID;
    [vc setHidesBottomBarWhenPushed:YES];
    [self showViewController:vc sender:self];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"pool";
    NewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.model = self.dataSource[indexPath.row];
    
    detailVC *vc = [[detailVC alloc]init];
    vc.ID = cell.IDD;
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
