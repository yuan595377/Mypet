//
//  ViewControllerOfHJ.m
//  Program
//
//  Created by Program on 16/5/18.
//  Copyright © 2016年 Program. All rights reserved.
//

#import "ViewControllerOfHJ.h"
#import "ViewControllerOfHJOfChange.h"
#import "ViewControllerOfAlarmClock.h"
#import "TableViewCellOfHJClock.h"
#import "CoreDataManager.h"
#import "Times+CoreDataClass.h"

@interface ViewControllerOfHJ ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *imageViewOfNcircular;
@property (nonatomic, strong) UIImageView *imageViewOfWcircular;
@property (nonatomic, strong) UILabel *labelOfTime;
@property (nonatomic, strong) UILabel *labelOfDay;
@property (nonatomic, strong) UIView *viewOfSeq;
@property (nonatomic, strong) UITableView *tableView;//闹钟
@property (nonatomic, assign) NSInteger hour;// 小时
@property (nonatomic, assign) NSInteger minutes;// 分钟
@property (nonatomic, strong) NSString *label;// 标签
@property (nonatomic, strong) CoreDataManager *manager;
@property (nonatomic, strong) NSMutableArray *arrOfSelect;// 闹钟信息
@end

@implementation ViewControllerOfHJ

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.manager = [CoreDataManager shareManager];
    NSLog(@"%@",self.manager.applicationDocumentsDirectory);

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createImageView];
    [self createAnimation];
    [self timeAction];
    [self getBackGroundImage];
    // 时间改变
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    // 闹钟
    [self createTableView];
    
}

- (void)handleData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Times" inManagedObjectContext:self.manager.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSError *error = nil;
    NSArray *fetchedObjects = [self.manager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    self.arrOfSelect = [NSMutableArray arrayWithArray:fetchedObjects];//[NSArray arrayWithArray:fetchedObjects].mutableCopy;
    [_tableView reloadData];
    if (fetchedObjects == nil) {
        NSLog(@"%@", error);
    }
    
}

#pragma mark  创建Tableview
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.imageView addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[TableViewCellOfHJClock class] forCellReuseIdentifier:@"pool"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageViewOfWcircular.mas_bottom).offset(30);
        make.left.equalTo(self.imageView).offset(20);
        make.right.equalTo(self.imageView).offset(-20);
        make.bottom.equalTo(self.imageView).offset(-70);
    }];
}

#pragma mark 返回个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.arrOfSelect.count;

}
#pragma mark cell赋值

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCellOfHJClock *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = NO;
    
    Times *model = self.arrOfSelect[indexPath.row];
    NSInteger hour = model.hour + 1;
    NSString *str = [NSString stringWithFormat:@"%ld", hour];
    
    cell.labelOfTime.text = [[str stringByAppendingString:@":"] stringByAppendingString:[NSString stringWithFormat:@"%d", model.minutes]];
    
    if (model.week.length == 14) {
        cell.labelOfWeek.text = @"小小闹钟,叫醒您的每一天";
    }else if ([model.week isEqualToString:@"周一周二周三周四周五"] || [model.week isEqualToString:@"周五周四周三周二周一"]){
        cell.labelOfWeek.text = @"工作日,不要太累哦!";
    }else{
    
        cell.labelOfWeek.text = model.week;
    }
    
    cell.labelOfLabel.text = model.label;

    return cell;
    
    
}

#pragma mark - 点击事件 删除闹铃
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除这个闹铃吗? " preferredStyle:UIAlertControllerStyleAlert];
    [alter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        Times *model = self.arrOfSelect[indexPath.row];
        // 删除本地推送
        NSString *time = [NSString stringWithFormat:@"%hd:%hd:%@", model.hour, model.minutes, model.music];
        if (model.week.length == 14) {
            // 获取本地推送数组
            NSArray *arr = [[UIApplication sharedApplication]scheduledLocalNotifications];
            for (UILocalNotification *localtion in arr) {
                if ([[[localtion userInfo]objectForKey:@"music"] isEqualToString:time]) {
                    // 取消本地推送
                    [[UIApplication sharedApplication]cancelLocalNotification:localtion];
                }
            }
        }else
        {
            NSArray *arr = [[UIApplication sharedApplication]scheduledLocalNotifications];
            // 获取日期 
            for (NSInteger i = 0; i < model.week.length / 2; i++) {
                NSString *string = [model.week substringWithRange:NSMakeRange(i * 2, 2)];
                for (UILocalNotification *location in arr) {
                    if ([[[[location userInfo]objectForKey:@"music"] stringByAppendingString:string] isEqualToString:[NSString stringWithFormat:@"%hd:%hd:%@%@", model.hour, model.minutes, model.music, string]]) {
                        
                        [[UIApplication sharedApplication] cancelLocalNotification:location];
                        
                    }
                }
            }
        }

        [self.manager.managedObjectContext deleteObject:model];
        [self.manager saveContext];
        [self.arrOfSelect removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:YES];
    }]];
    [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alter animated:YES completion:^{
        
    }];

}
#pragma mark 返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}
- (void)createAnimation
{
    // 最里层圆
    self.imageViewOfNcircular = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yuan"]];
    _imageViewOfNcircular.frame = CGRectMake(0, 0, 170, 170);
    _imageViewOfNcircular.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3);
    [self.view addSubview:_imageViewOfNcircular];
    
    // 最外层圆
    self.imageViewOfWcircular = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yuan"]];
    _imageViewOfWcircular.frame = CGRectMake(0, 0, 200, 200);
    _imageViewOfWcircular.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3);
    [self.view addSubview:_imageViewOfWcircular];
    // 日期
    self.labelOfDay = [[UILabel alloc]init];
    _labelOfDay.frame = CGRectMake(0, 0, 150, 30);
    _labelOfDay.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3.5);
    _labelOfDay.textAlignment = YES;
    _labelOfDay.textColor = [UIColor whiteColor];
    [self.view addSubview:_labelOfDay];
    
    // 时间
    self.labelOfTime = [[UILabel alloc]init];
    _labelOfTime.frame = CGRectMake(0, 0, 150, 40);
    _labelOfTime.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/3);
    _labelOfTime.textAlignment = YES;
    _labelOfTime.textColor = [UIColor whiteColor];
    _labelOfTime.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:_labelOfTime];
    // 分割线
    self.viewOfSeq = [[UIView alloc]init];
    _viewOfSeq.frame = CGRectMake(0, 0, 130, 1);
    _viewOfSeq.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height / 2.6);
    _viewOfSeq.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewOfSeq];
    

}
- (void)timeAction
{
    
    // 获得系统时间
    NSDate *senddate=[NSDate date];
    // 设置时间格式
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss"];
    NSString *morelocationString=[dateformatter stringFromDate:senddate];
    // 获得系统日期
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit| NSWeekdayCalendarUnit;
    NSDateComponents *conponent= [cal components:unitFlags fromDate:senddate];

    // 日期数组
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    // 获取当前日期
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    NSInteger week = [conponent weekday];
    NSString *nsDateString= [NSString  stringWithFormat:@"%2ld/%2ld %@",month,day, arrWeek[week - 1]];
    // 设置日期
     _labelOfDay.text = nsDateString;
    // 设置时间
     _labelOfTime.text = morelocationString;
    
}

- (void)createImageView
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    // 一键换肤按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 20, 80, 30);
    [_imageView addSubview:button];
//    [button setBackgroundImage:[UIImage imageNamed:@"pp"] forState:UIControlStateNormal];
    [button setTitle:@"一键换肤" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    // 设置闹钟按钮
    UIButton *buttonOfTool = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageView addSubview:buttonOfTool];
    buttonOfTool.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonOfTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(80);
        make.top.equalTo(self.imageView.mas_top).offset(0);
        make.right.equalTo(self.imageView.mas_right).offset(-20);
    }];
//    [buttonOfTool setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [buttonOfTool setTitle:@"添加闹钟" forState:UIControlStateNormal];
    [buttonOfTool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonOfTool addTarget:self action:@selector(clock:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark - 闹钟VC
- (void)clock:(UIButton *)clock
{
    ViewControllerOfAlarmClock *VCOfClock = [[ViewControllerOfAlarmClock alloc]init];
    [self presentViewController:VCOfClock animated:YES completion:^{
        
    }];
}
#pragma mark - 换肤响应事件
#pragma mark - 从相册中获取图片,选择提供的图片 存储本地 再次启动时 无法判断 要移除
- (void)change:(UIButton *)change
{
    ViewControllerOfHJOfChange *changeVC = [[ViewControllerOfHJOfChange alloc]init];
    // 实现block
    changeVC.passValue = ^(NSString *image){
        
        self.imageView.image = [UIImage imageNamed:image];
        // 系统图片存储本地
        [[NSUserDefaults standardUserDefaults]setObject:image forKey:@"currentImage"];
        // 相册图片移除本地
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"image"];
    };
    // 调用block
    changeVC.passImage = ^(UIImage *imageOfFile){
        self.imageView.image = imageOfFile;
        // 提供的图片移除本地
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"currentImage"];
       
    };
    [self presentViewController:changeVC animated:YES completion:^{
        
    }];
}
#pragma mark - 程序重启时 获取上一次选取的图片作为当前的背景图片
- (void)getBackGroundImage
{
    NSString *image = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentImage"];
    if (image.length == 0) {
        _imageView.image = [UIImage imageNamed:@"H1"];
    }else {
        self.imageView.image = [UIImage imageNamed:image];
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault dataForKey:@"image"]) {
        self.imageView.image = [UIImage imageWithData:[userDefault dataForKey:@"image"]];
        }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self handleData];
    
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
