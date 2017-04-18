//
//  PC_VC.m
//  MyPet
//
//  Created by 袁立康 on 17/3/26.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PC_VC.h"
#import "setVC.h"
#import <BmobSDK/BmobFile.h>
#import "ViewController.h"
@interface PC_VC ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain)UITableView *tabelOfPC;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nickName;
@end

@implementation PC_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideNavi];
    [self addButton];
    [self createSubview];
    
}

- (void)hideNavi {
    
    self.navigationController.navigationBar.subviews[0].alpha = 0;
    self.navigationItem.title = nil;
}


- (void)createSubview {
    
    _tabelOfPC = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tabelOfPC.delegate = self;
    _tabelOfPC.dataSource = self;
    _tabelOfPC.showsVerticalScrollIndicator = NO;
    [_tabelOfPC registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool"];

    //设置顶部背景
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [self addAvatar_Nickname];

    _tabelOfPC.tableHeaderView = self.headerView;
    [self.view addSubview:_tabelOfPC];

}
//添加设置按钮
- (void)addButton {
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]
                                 initWithTitle:nil
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(set)];
    [rightBtn setImage:[UIImage imageNamed:@"setting.png"]];
    [rightBtn setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = rightBtn;

}

#pragma mark ----添加头像和昵称
- (void)addAvatar_Nickname {
    
    self.avatar = [[UIImageView alloc]init];
    [self touchChangeBackbackground];
    [self.headerView addSubview:self.avatar];
    self.avatar.backgroundColor = [UIColor brownColor];
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 40;
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(self.headerView).with.offset(SCREEN_WIDTH / 2 - 40);
        make.top.equalTo(self.headerView.mas_top).with.offset(10);
        
    }];
    
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBackground)];
    [self.avatar addGestureRecognizer:tap];
    
    //添加昵称
    self.nickName = [[UILabel alloc]init];
    self.nickName.text = [EMClient sharedClient].currentUsername;
    self.nickName.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.left.equalTo(self.headerView).with.offset(SCREEN_WIDTH / 2 - 50);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(10);
    }];
  
}


- (void)set {
    setVC *vc = [[setVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark -------设置分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = [UIColor grayColor];
    return view;
}


- (void)touchChangeBackbackground {
    
    self.avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBackground)];
    //给ImageView添加手势
    [self.avatar addGestureRecognizer:tap];
    
}

//手势事件
- (void)changeBackground{
    
    if ([EMClient sharedClient].isLoggedIn) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //按钮：从相册选择，类型：UIAlertActionStyleDefault
        [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self chooseImg];
        }]];
        
        //按钮：拍照，类型：UIAlertActionStyleDefault
        [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePhoto];
        }]];
        //按钮：取消，类型：UIAlertActionStyleCancel
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ViewController alloc]init];
    
    }


}

#pragma mark ----相册选择照片
- (void)chooseImg {
    //初始化UIImagePickerController
    UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
    //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
    //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
    //获取方方式3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
    PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//方式1
    //允许编辑，即放大裁剪
    PickerImage.allowsEditing = YES;
    //自代理
    PickerImage.delegate = self;
    //页面跳转
    [self presentViewController:PickerImage animated:YES completion:nil];

}

- (void)takePhoto {
    NSLog(@"点击拍照");
    __block NSUInteger blockSourceType = 0;
    //相机
    blockSourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = blockSourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];

}


//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //把newPhono设置成头像
    self.avatar.image = newPhoto;
    [self saveImage:newPhoto withName:@"avatar.png"];
    //关闭当前界面，即回到主界面去
    [self dismissViewControllerAnimated:YES completion:nil];
}


//拉伸图片效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = self.view.frame.size.width; // 图片宽度
    CGFloat yOffset = scrollView.contentOffset.y;  // 偏移的y值
    if (yOffset < 0) {
        CGFloat totalOffset = 200 + ABS(yOffset);
        CGFloat f = totalOffset / 200;
        self.headerImageView.frame =  CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset); //拉伸后的图片的frame应该是同比例缩放。
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}
    
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我的关注";
    }else {
        cell.textLabel.text = @"收藏";
    }
    
    return cell;

  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self getAvatar_nickName];

}


#pragma mark - 保存图片至本地沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    NSLog(@"fullPath:%@", fullPath);
    BmobFile *file = [[BmobFile alloc]initWithFilePath:fullPath];
    BmobObject *obj = [[BmobObject alloc]initWithClassName:[EMClient sharedClient].currentUsername];
    
    [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [obj setObject:file forKey:@"li"];
            //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
            [obj saveInBackground];
            //打印file文件的url地址
            NSLog(@"file1.url:%@,obj:%@",file.url,obj);
            [self.avatar sd_setImageWithURL:[NSURL URLWithString:file.url]];
            [SVProgressHUD dismiss];
        }
    } withProgressBlock:^(CGFloat progress) {
        
        [SVProgressHUD showProgress:progress status:nil];
        
    }];
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (void)getAvatar_nickName {
    
    if ([EMClient sharedClient].isLoggedIn) {
        BmobObject *obj = [[BmobObject alloc]initWithClassName:[EMClient sharedClient].currentUsername];
        
        BmobFile *file = (BmobFile*)[obj objectForKey:@"li"];
        NSLog(@"url:%@, file:%@, obj:%@", file.url, file, obj);
        self.avatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:file.url]]];
    }else {
        self.avatar.image = nil;
    
    }

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    MyPubVC *vc = [[MyPubVC alloc]init];
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
