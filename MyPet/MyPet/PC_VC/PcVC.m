//
//  PcVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/22.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PcVC.h"

@interface PcVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)UILabel *follow;
@property (nonatomic, retain)UILabel *action;
@property (nonatomic, retain)UILabel *fans;
@property (nonatomic, retain)UILabel *nick_name;
@property (nonatomic, retain)UILabel *dec;
@property (nonatomic, retain)UIImageView *avatar;



@end

@implementation PcVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    

}


- (void)setSubView {
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self setHeaderView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool"];


}

- (void)setHeaderView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 189)];
    self.avatar = [[UIImageView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.avatar];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    NSLog(@"图片路径:%@", fullPath);
    [self.avatar sd_setImageWithURL:[NSURL fileURLWithPath:fullPath] placeholderImage:[UIImage imageNamed:@"112.jpeg"]];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(view).with.offset(10);
        make.top.equalTo(view.mas_top).with.offset(15);
    }];
    self.avatar.layer.cornerRadius = 35;
    self.avatar.layer.masksToBounds = YES;

    self.nick_name = [[UILabel alloc]init];
    [view addSubview:_nick_name];
    [self.nick_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(170, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.top.equalTo(view.mas_top).with.offset(25);
        
    }];
    self.nick_name.text = [EMClient sharedClient].currentUsername;
    
    self.dec = [[UILabel alloc]init];
    [view addSubview:_dec];
    [self.dec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(170, 20));
        make.left.equalTo(self.avatar.mas_right).with.offset(10);
        make.top.equalTo(_nick_name.mas_bottom).with.offset(10);
        
    }];
    [self.dec setFont:[UIFont systemFontOfSize:13]];
    self.dec.text = @"爱宠日记";
    
    UIView *view4 = [[UIView alloc]init];
    view4.backgroundColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:0.5];
    [view addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.left.equalTo(view).with.offset(0);
        make.top.equalTo(_avatar.mas_bottom).with.offset(20);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button1];
    [button1 setFont:[UIFont systemFontOfSize:13]];
    [button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button1 setTitle:@"动态" forState:UIControlStateNormal];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(view).with.offset(30);
        make.top.equalTo(view4.mas_bottom).with.offset(10);
        
    }];
    [button1 addTarget:self action:@selector(pushaction) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button2];
    [button2 setFont:[UIFont systemFontOfSize:13]];
    [button2 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button2 setTitle:@"关注" forState:UIControlStateNormal];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(button1.mas_right).with.offset(50);
        make.top.equalTo(view4.mas_bottom).with.offset(10);
        
    }];
    [button2 addTarget:self action:@selector(folo) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button3];
    [button3 setFont:[UIFont systemFontOfSize:13]];
    [button3 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button3 setTitle:@"粉丝" forState:UIControlStateNormal];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 25));
        make.left.equalTo(button2.mas_right).with.offset(50);
        make.top.equalTo(view4.mas_bottom).with.offset(10);
        
    }];
    [button3 addTarget:self action:@selector(fan) forControlEvents:UIControlEventTouchDown];
    
    UIImageView *i = [[UIImageView alloc]init];
    [view addSubview:i];
    i.image = [UIImage imageNamed:@"脚印.png"];
    [i mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(29, 25));
        make.left.equalTo(button3.mas_right).with.offset(50);
        make.top.equalTo(view4.mas_bottom).with.offset(10);
        
    }];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button4];
    [button4 setFont:[UIFont systemFontOfSize:13]];
    [button4 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [button4 setTitle:@"我的资料" forState:UIControlStateNormal];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 25));
        make.left.equalTo(button3.mas_right).with.offset(38);
        make.top.equalTo(i.mas_bottom).with.offset(2);
        
    }];
    [button4 addTarget:self action:@selector(mymsg) forControlEvents:UIControlEventTouchDown];
    
    UIView *view5 = [[UIView alloc]init];
    view5.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    [view addSubview:view5];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 18));
        make.left.equalTo(view).with.offset(0);
        make.top.equalTo(button4.mas_bottom).with.offset(12);
    }];
    
    
    self.tableView.tableHeaderView = view;
}


- (void)pushaction {
    
    MyPubVC *vc = [[MyPubVC alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)mymsg {

    MyInfoVC *vc = [[MyInfoVC alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)folo {

    [ThemeManage shareThemeManage].isNight = ![ThemeManage shareThemeManage].isNight;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeColor" object:nil];
    [[NSUserDefaults standardUserDefaults] setBool:[ThemeManage shareThemeManage].isNight forKey:@"night"];
    //夜间模式
}

- (void)fan {
  [SVProgressHUD showSuccessWithStatus:@"我的粉丝"];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    long section = indexPath.section;
    long row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (section) {
        case 0:
            cell.textLabel.text = @"我的宠物";
            cell.imageView.image = [UIImage imageNamed:@"mypet.png"];
            break;
        case 1:
            if(row == 0)
            {
                cell.textLabel.text =  @"我的二维码";
                cell.imageView.image = [UIImage imageNamed:@"二维码-3.png"];
            }else if(row == 1){
                cell.textLabel.text =  @"扫一扫";
                cell.imageView.image = [UIImage imageNamed:@"扫码.png"];
            }else {
                cell.textLabel.text =  @"设置";
                cell.imageView.image = [UIImage imageNamed:@"set4.png"];
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
            [SVProgressHUD showSuccessWithStatus:@"我的宠物"];
            break;
        case 1:
            if(row == 0)
            {
                [self goMycCode];
            }else if(row == 1){
                [self goScanMyCode];
            }else {
                [self goSet];
            }
            break;
        default:
            break;
            
            
    }
}

- (void)goSet {

    setVC *vc = [[setVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)goMycCode {

    MyCodeVC *vc = [[MyCodeVC alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goScanMyCode {
    ScanVc *vc = [[ScanVc alloc]init];
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
