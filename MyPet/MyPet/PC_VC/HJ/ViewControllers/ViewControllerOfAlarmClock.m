//
//  ViewControllerOfAlarmClock.m
//  Program
//
//  Created by Jasmine on 16/5/20.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "ViewControllerOfAlarmClock.h"
#import "ViewControllerOfAddClock.h"
#import "CollectionViewCellOfHJOfClock.h"
#import "CoreDataManager.h"
#import "Times+CoreDataClass.h"

@interface ViewControllerOfAlarmClock ()<UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, strong) UIButton *buttonOfClock;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arr;// 星期数组
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) NSMutableArray *mArrOfhours;
@property (nonatomic, strong) NSMutableArray *mArrOfminutes;
@property (nonatomic, assign) NSInteger hour;// 记录小时
@property (nonatomic, assign) NSInteger minutes;// 记录分钟
@property (nonatomic, strong) UITextField *textFieldOfLabel;// 标签
@property (nonatomic, assign) NSInteger week;// 记录星期
@property (nonatomic, strong) CoreDataManager *manager;
@property (nonatomic, strong) NSMutableArray *arrOfSelectedWeek;// 选中的星期数组
@property (nonatomic, strong) NSMutableString *stringOfAppending;// 拼接选中的数组的字符串
@property (nonatomic, strong) NSString *musicOfName;
@end

@implementation ViewControllerOfAlarmClock

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arrOfSelectedWeek = [NSMutableArray array];
    
    self.stringOfAppending = [NSMutableString string];

    // 背景图片
    [self createImageView];
    // 其他控件
    [self others];
    //闹钟时间试图
    [self createCollectionView];
    self.arr = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    [self createTime];
    // 设置起始时间
    self.hour = 5;
    self.minutes = 22;
    self.manager = [CoreDataManager shareManager];
    
 //   NSLog(@"%@", self.manager.applicationDocumentsDirectory);
    
}
#pragma mark - 闹钟日期试图
- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width) / 7 - 10 , ([UIScreen mainScreen].bounds.size.height) / 7 - 40);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 7 - 30) collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
#pragma mark - 允许多选
    _collectionView.allowsMultipleSelection = YES;

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CollectionViewCellOfHJOfClock class] forCellWithReuseIdentifier:@"cell"];
    
}
#pragma mark - 时间

- (void)createTime
{
    self.mArrOfhours = [NSMutableArray array];
    self.mArrOfminutes = [NSMutableArray array];
    
    for (int i = 1; i <= 24; i ++) {
        [_mArrOfhours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 0; i <= 60; i ++) {
        [_mArrOfminutes addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.picker = [[UIPickerView alloc]init];
    [self.view addSubview:_picker];
    _picker.translatesAutoresizingMaskIntoConstraints = NO;
    [_picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.collectionView.mas_bottom).offset(40);
        make.bottom.equalTo(self.buttonOfClock.mas_top).offset(-40);
        
    }];
    _picker.delegate = self;
    _picker.dataSource = self;
   
    [_picker selectRow:5 inComponent:0 animated:YES];
    [_picker selectRow:22 inComponent:1 animated:YES];
  
}

#pragma mark - pickerView协议方法
#pragma mark - 获取指定列的行数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

#pragma mark - 返回每一列对应的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.mArrOfhours.count;
    }else {
        return self.mArrOfminutes.count;
        
    }
}

#pragma mark - 返回显示的文本
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NSAttributedString *title = [[NSAttributedString alloc]initWithString:[self.mArrOfhours[row]stringByAppendingString:@"点"] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return title;
    }else {
        NSAttributedString *title = [[NSAttributedString alloc]initWithString:[self.mArrOfminutes[row]stringByAppendingString:@"分"] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return title;
    }
}
#pragma mark - 设置行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
#pragma mark - 点击事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.hour = row;
    }else {
        self.minutes = row;

    }
   
}

#pragma mark - 周一...
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellOfHJOfClock *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.labelOfWeek.text = self.arr[indexPath.row];
    return cell;
}
#pragma mark - 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    // 设置选中时的背景颜色
    CollectionViewCellOfHJOfClock *cellOfSelected = (CollectionViewCellOfHJOfClock *)[collectionView cellForItemAtIndexPath:indexPath];
    cellOfSelected.labelOfWeek.textColor = [UIColor colorWithRed:0.21 green:0.69 blue:0.64 alpha:1.00];
     [self.arrOfSelectedWeek addObject:self.arr[indexPath.row]];
    self.week = indexPath.row;
    
}

#pragma mark - 颜色反选
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 通过indexPath获取对应cell
    CollectionViewCellOfHJOfClock *cell = ( CollectionViewCellOfHJOfClock *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.labelOfWeek.textColor = [UIColor whiteColor];
    // 移除
    [self.arrOfSelectedWeek removeObject:self.arr[indexPath.row]];
}

#pragma mark - 其他控件
- (void)others
{
    self.buttonOfClock = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_buttonOfClock];
    [_buttonOfClock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-200);
        make.height.mas_offset(40);
    }];
    // 获取当前铃声名字
    [_buttonOfClock setTitle:@"铃声:Airship" forState:UIControlStateNormal];
    [_buttonOfClock setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buttonOfClock addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    // 标签
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.buttonOfClock.mas_bottom).offset(20);
        make.height.mas_offset(40);
    }];
    label.text = [[NSString stringWithFormat:@"  "]stringByAppendingString:@"标签:"];
    label.textColor = [UIColor whiteColor];
    
    self.textFieldOfLabel = [[UITextField alloc]init];
    [self.view addSubview:_textFieldOfLabel];
    _textFieldOfLabel.placeholder = @"啦啦啦, 起床啦";
    _textFieldOfLabel.textColor = [UIColor colorWithRed:0.21 green:0.69 blue:0.64 alpha:1.00];
    _textFieldOfLabel.delegate = self;
    [_textFieldOfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(65);
        make.right.equalTo(self.view).offset(-10);
        make.top.equalTo(self.buttonOfClock.mas_bottom).offset(20);
        make.height.mas_offset(40);
    }];
    
    
}

#pragma mark - 添加铃声
- (void)next:(UIButton *)next
{
    ViewControllerOfAddClock *add = [[ViewControllerOfAddClock alloc]init];
    add.passAudioName = ^(NSString *name)
    {
        [_buttonOfClock setTitle:[NSString stringWithFormat:@"铃声:  %@", name] forState:UIControlStateNormal];
#pragma mark - 记录闹铃声音
        self.musicOfName = name;

    };
    add.image = self.imageView.image;
    [self presentViewController:add animated:YES completion:^{
        
    }];
}
- (void)createImageView
{
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _imageView.image = [UIImage imageNamed:@"H5"];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    // 返回上一页面button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 20, 70, 30);
    [_imageView addSubview:button];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"X 关闭" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(cha:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置完成
    UIButton *buttonOfFinish = [UIButton buttonWithType:UIButtonTypeSystem];
    [_imageView addSubview:buttonOfFinish];
    buttonOfFinish.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonOfFinish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(40);
        make.top.equalTo(self.imageView.mas_top).offset(20);
        make.right.equalTo(self.imageView.mas_right).offset(-20);
    }];
    [buttonOfFinish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOfFinish.titleLabel.font = [UIFont systemFontOfSize:16];
    [buttonOfFinish setTitle:@"完成" forState:UIControlStateNormal];
    [buttonOfFinish addTarget:self action:@selector(clock:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 闹钟设置完成
- (void)clock:(UIButton *)clock
{
    
    NSUserDefaults *sr = [NSUserDefaults standardUserDefaults];
    [sr setObject:self.textFieldOfLabel.text forKey:@"notic"];
    [sr setObject:@"yes" forKey:@"clock"];
    
    for (NSString *ss in self.arrOfSelectedWeek) {
        [self.stringOfAppending appendString:ss];
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Times" inManagedObjectContext:self.manager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"hour = %@ and minutes = %@ and week = %@", [NSNumber numberWithInteger:self.hour], [NSNumber numberWithInteger:self.minutes], self.stringOfAppending];
    [fetchRequest setPredicate:pre];
    NSError *error = nil;
    
    NSArray *fetchedObjects = [self.manager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
   
    if (fetchedObjects.count == 0) {
        if (self.stringOfAppending.length == 0) {
         //   NSLog(@"请选择日期");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择日期" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                // 返回上一页
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }]];
            
            [self presentViewController:alert animated:YES completion:^{
                
            }];
        }else {
            Times *model = [NSEntityDescription insertNewObjectForEntityForName:@"Times" inManagedObjectContext:self.manager.managedObjectContext];
            model.hour = self.hour;
            model.minutes = self.minutes;
            model.label = self.textFieldOfLabel.text;
            model.week = self.stringOfAppending;
            if (self.musicOfName.length == 0) {
                model.music = @"Airship";
            }else{
                model.music = self.musicOfName;
            }
            [self.manager saveContext];
            
#pragma mark - 发送本地通知 闹铃响起
            if (_arrOfSelectedWeek.count == 7) {
                
                //解决iOS8以后本地推送无法接收到推送消息的问题
                //获取系统的版本号
                float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
                if (systemVersion >= 8.0) {
                    //设置推送消息的类型
                    UIUserNotificationType type = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
                    //将类型添加到设置里
                    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
                    //将设置内容注册到系统管理里面
                    [[UIApplication sharedApplication]registerUserNotificationSettings:settings];
                }
                // 初始化本地通知
                UILocalNotification *notifocation = [[UILocalNotification alloc]init];
        
                if (notifocation) {
                    // 设置从什么时候开始推送
                    notifocation.fireDate = [NSDate dateWithTimeIntervalSince1970:(((self.hour + 1 ) - 8)) * 60 * 60 + self.minutes * 60];
                    // 执行周期 每一天
                    notifocation.repeatInterval = kCFCalendarUnitDay;
                    // 铃声
                    if (self.musicOfName.length == 0) {
                        notifocation.soundName = @"Airship.mp3";
                    }
                    else {
                        notifocation.soundName = [NSString stringWithFormat:@"%@.mp3", self.musicOfName];
                    }
                    // 通知内容
                   notifocation.alertBody = self.textFieldOfLabel.text;
                    // 通知参数
                    NSDictionary *information = nil;
                    if (self.musicOfName.length == 0) {
//                        information = [NSDictionary dictionaryWithObject:@"Airship" forKey:@"music"];
                        
                        information = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld:%ld:%@", self.hour, self.minutes, @"Airship"] forKey:@"music"];
                       
                    }else {
                    // 通知参数
//                    information = [NSDictionary dictionaryWithObject:self.musicOfName forKey:@"music"];
                        information = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld:%ld:%@", self.hour, self.minutes, self.musicOfName] forKey:@"music"];
                    }

                    notifocation.userInfo = information;
                    // 添加到系统
                    [[UIApplication sharedApplication]scheduleLocalNotification:notifocation];
                }
            }else
            {
                for (NSString *week in self.arrOfSelectedWeek) {
                    UILocalNotification *notification = [[UILocalNotification alloc]init];
                    if (notification) {
                        NSInteger day = 0;
                        if ([week isEqualToString:@"周四"]) {
                            day = 0;
                        }
                        if ([week isEqualToString:@"周五"]) {
                            day = 1;
                        }
                        if ([week isEqualToString:@"周六"]) {
                            day = 2;
                        }
                        if ([week isEqualToString:@"周日"]) {
                            day = 3;
                        }
                        if ([week isEqualToString:@"周一"]) {
                            day = 4;
                        }
                        if ([week isEqualToString:@"周二"]) {
                            day = 5;
                        }
                        if ([week isEqualToString:@"周三"]) {
                            day = 6;
                        }
                        notification.fireDate = [NSDate dateWithTimeIntervalSince1970:(self.hour + 1 - 8) * 60 * 60 + self.minutes * 60 + day * 24 * 60 * 60 ];
                        // 每周都响
                        notification.repeatInterval = kCFCalendarUnitWeek;
                        // 铃声
                        if (self.musicOfName.length == 0) {
                            notification.soundName = @"Airship.mp3";
                        }
                        else {
                            notification.soundName = [NSString stringWithFormat:@"%@.mp3", self.musicOfName];
                        }
                        // 通知内容
                        notification.alertBody = self.textFieldOfLabel.text;
                        // 通知参数
                        NSDictionary *information = nil;
                        if (self.musicOfName.length == 0) {
//                            information = [NSDictionary dictionaryWithObject:@"Airship" forKey:@"music"];
                            information = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld:%ld:%@", self.hour, self.minutes, @"Airship"] forKey:@"music"];
                        }else {
                            // 通知参数
//                            information = [NSDictionary dictionaryWithObject:self.musicOfName forKey:@"music"];
                            information = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld:%ld:%@", self.hour, self.minutes, self.musicOfName] forKey:@"music"];
                        }
                        notification.userInfo = information;
                        // 添加到系统
                        [[UIApplication sharedApplication]scheduleLocalNotification:notification];

                        
                    }
                    
                }
            }
#pragma mark - 本地通知
            // 返回上一页
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }else {
       // NSLog(@"已经存在");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该闹铃已经存在" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        [self performSelector:@selector(dismiss) withObject:alert afterDelay:2];
    }
    if (fetchedObjects == nil) {
        NSLog(@"%@", error);
    }

   
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    
}
#pragma mark - 返回上一页
- (void)cha:(UIButton *)cha
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y  - 120, self.view.frame.size.width, self.view.frame.size.height);

    }];
   
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = self.view.bounds;
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = self.view.bounds;
    }];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
