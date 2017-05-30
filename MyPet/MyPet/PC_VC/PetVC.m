//
//  PetVC.m
//  MyPet
//
//  Created by 袁立康 on 17/5/30.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PetVC.h"

@interface PetVC ()<UITableViewDelegate, UITableViewDataSource,LEActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>;
@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *dataSource;
@property (nonatomic, retain)UIImageView *avatar;

@end

@implementation PetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self fetchData];
    [self creatTableView];
    self.title = @"我的宠物";
    
}

- (void)fetchData {
    
    
    
    
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[PetCell class] forCellReuseIdentifier:@"pool"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    [view NightWithType:UIViewColorTypeNormal];
    self.avatar = [[UIImageView alloc]init];
    self.avatar.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImg)];
    [self.avatar addGestureRecognizer:tap];
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(view).with.offset(SCREEN_WIDTH / 2 - 35);
        make.top.equalTo(view.mas_top).with.offset(60);
    }];
    [self.avatar sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
    self.avatar.layer.cornerRadius = 35;
    self.avatar.layer.masksToBounds = YES;
    self.tableView.tableHeaderView = view;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)saveInfo {
    NSLog(@"保存信息");

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
//    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.86 green:0.85 blue:0.86 alpha:1.00];
    if (indexPath.row == 0) {
        cell.title.text = @"宠物名称";
        [cell.add setTitle:@"设置宠物昵称" forState:UIControlStateNormal];
        [cell.add addTarget:self action:@selector(setnickname:) forControlEvents:UIControlEventTouchDown];
    }else if (indexPath.row == 1) {
        cell.title.text = @"宠物性别";
        [cell.add setTitle:@"设置宠物性别" forState:UIControlStateNormal];
        [cell.add addTarget:self action:@selector(setsex) forControlEvents:UIControlEventTouchDown];

    }else if (indexPath.row == 2) {
        cell.title.text = @"宠物品种";
        [cell.add setTitle:@"设置宠物品种" forState:UIControlStateNormal];
        [cell.add addTarget:self action:@selector(setkind) forControlEvents:UIControlEventTouchDown];

    }else {
        cell.title.text = @"宠物生日";
        [cell.add setTitle:@"选填" forState:UIControlStateNormal];
        [cell.add addTarget:self action:@selector(setbirth) forControlEvents:UIControlEventTouchDown];

    }
    
    
    return cell;
}

- (void)setnickname:(UIButton *)bt {
    
    petNameVC *vc = [[petNameVC alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];


}


- (void)setsex:(UIButton *)bt {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"title,nil时不显示"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:@"男", @"女",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    
}

- (void)setkind:(UIButton *)bt {

}

- (void)setbirth:(UIButton *)bt {

  
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
    [self saveImage:newPhoto withName:@"petavatar.png"];
    //关闭当前界面，即回到主界面去
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片至本地沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    NSLog(@"fullPath:%@", fullPath);
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    [self saveBackGroundAvatar];
}

- (void)saveBackGroundAvatar {
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"petavatar.png"];
    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"infoAvatar"];
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:fullPath];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
            [obj setObject:file1  forKey:@"img"];
            [obj setObject:file1.url forKey:@"petavatar"];
            BmobUser *bUser = [BmobUser currentUser];
            //更新number为30
            [bUser setObject:file1.url forKey:@"petavatar"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                NSLog(@"error %@",[error description]);
            }];
            //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
            [obj saveInBackground];
            //打印file文件的url地址
            
        }else{
            //进行处理
        }
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
