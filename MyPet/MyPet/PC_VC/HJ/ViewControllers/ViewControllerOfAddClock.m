//
//  ViewControllerOfAddClock.m
//  Program
//
//  Created by Jasmine on 16/5/20.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "ViewControllerOfAddClock.h"
#import <AudioToolbox/AudioToolbox.h>

// AudioToolbox:本质:将简短的声音注册到系统
// 获取系统提示音ID 一个ID对应一个音效文件 它表示要使用的声音文件
static SystemSoundID soundID = 0;

@interface ViewControllerOfAddClock ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation ViewControllerOfAddClock

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self goBack];
    [self createTableView];
    [self handleData];
}
#pragma mark - 数据处理
- (void)handleData
{
    self.arr = @[@"Airship", @"Alarm Close", @"Alien Metron", @"Astronaut", @"BoDeSa", @"Calculator", @"Falling Stone", @"Firefly", @"Lantern Star", @"Lemon Port",@"Milky Way", @"Mineral", @"Mushrooms Villain", @"Nothing", @"Rich Base", @"Rocket Launch", @"Satellite", @"Stars", @"Time Tunnel", @"Time Machine", @"UFO", @"Unknown Creature", @"Wormhole"];
}
#pragma mark - 返回按钮
- (void)goBack
{
    // 背景图片
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _imageView.image = self.image;
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    // 返回按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(10, 20, 70, 30);
    [_imageView addSubview:button];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"< 返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    // 标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(160, 25, 40, 25)];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    [self.imageView addSubview:label];
    label.text = @"铃声";
    
}
- (void)createTableView
{
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.backgroundColor = [UIColor clearColor];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.showsVerticalScrollIndicator = NO;
    [_tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.arr[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}
#pragma mark - tableView的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取音乐
    NSString *audioFile = [[NSBundle mainBundle]pathForResource:self.arr[indexPath.row] ofType:@"mp3"];
    // 添加可选的系统声音完成回调，通知你的程序声音已经播放完毕 如果不使用一个接一个的短声音，一般可以跳过该步骤
    // 在播放完之后执行某些操作，注册一个播放完成回调函数
    // 播放完成
    AudioServicesDisposeSystemSoundID((SystemSoundID) soundID);
    // 清除声音 释放声音对象以及相关的所有资源
    AudioServicesRemoveSystemSoundCompletion((SystemSoundID)soundID);
    // 注册声音到系统
    if (audioFile) {
        NSURL *soundURL = [NSURL fileURLWithPath:audioFile];
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(soundURL), &soundID);
        if(err!= kAudioServicesNoError){
            NSLog(@"Could not load %@,error code:%d",soundURL,err);
        }
    }
    //开始播放声音 带有震动
   // AudioServicesPlayAlertSound((SystemSoundID)soundID);
    AudioServicesPlaySystemSound((SystemSoundID)soundID);
    // 调用block传递audionName
    self.passAudioName(self.arr[indexPath.row]);
    // 记录文字
//    [[NSUserDefaults standardUserDefaults]setObject:self.arr[indexPath.row] forKey:@"audioOfname"];
    
}

- (void)back:(UIButton *)back
{
    // 播放完成 根据ID释放自定义系统声音  
    AudioServicesDisposeSystemSoundID((SystemSoundID) soundID);
    // 清除声音 释放声音对象以及相关的所有资源
    AudioServicesRemoveSystemSoundCompletion((SystemSoundID)soundID);

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
