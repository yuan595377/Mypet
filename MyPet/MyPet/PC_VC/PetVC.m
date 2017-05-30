//
//  PetVC.m
//  MyPet
//
//  Created by 袁立康 on 17/5/30.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PetVC.h"

@interface PetVC ()<LEActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>;
@property (nonatomic, retain)NSMutableArray *dataSource;
@property (nonatomic, retain)UIImageView *avatar;

//name
@property (nonatomic, retain)UILabel *petname;
@property (nonatomic, retain)UIButton *namebut;

//sex
@property (nonatomic, retain)UILabel *petsex;
@property (nonatomic, retain)UIButton *sexbut;

//kind
@property (nonatomic, retain)UILabel *petkind;
@property (nonatomic, retain)UIButton *kindbut;

//birth
@property (nonatomic, retain)UILabel *petbirth;
@property (nonatomic, retain)UIButton *birthbut;


@property (nonatomic, retain)UIButton *saveBtn;



@end

@implementation PetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   
    [self fetchData];
    
    
}

- (void)fetchData {
    self.title = @"我的宠物";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    
    BmobUser *user = [BmobUser currentUser];
    if ([[user objectForKey:@"has_pet"] isEqual:@1]) {
        [self setHasPet];
    }else {
    
      [self creatTableView];
    }
    
    
    
    
    
}


- (void)setHasPet {
    
    BmobUser *user = [BmobUser currentUser];
    NSString *avatar = [NSString stringWithFormat:@"%@",[user objectForKey:@"petavatar"]];
    NSString *name = [NSString stringWithFormat:@"%@",[user objectForKey:@"petName"]];
    NSString *birth = [NSString stringWithFormat:@"%@",[user objectForKey:@"petBirth"]];
    NSString *sex = [NSString stringWithFormat:@"%@",[user objectForKey:@"petSex"]];
    NSString *kind = [NSString stringWithFormat:@"%@",[user objectForKey:@"petKind"]];


    
    self.avatar = [[UIImageView alloc]init];
    [self.view addSubview:self.avatar];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImg)];
    self.avatar.userInteractionEnabled = YES;
    [self.avatar addGestureRecognizer:tap];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 35);
        make.top.equalTo(self.view.mas_top).with.offset(100);
    }];
    self.avatar.layer.cornerRadius = 35;
    self.avatar.layer.masksToBounds = YES;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
    
    
    self.petname = [[UILabel alloc]init];
    self.petname.backgroundColor = [UIColor whiteColor];
    self.petname.text = [NSString stringWithFormat:@"宠物昵称:%@",name];
    [self.view addSubview:self.petname];
    [self.petname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(20);
    }];
    
    self.petsex = [[UILabel alloc]init];
    self.petsex.backgroundColor = [UIColor whiteColor];
    self.petsex.text = [NSString stringWithFormat:@"宠物性别:%@",sex];
    [self.view addSubview:self.petsex];
    [self.petsex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.petname.mas_bottom).with.offset(20);
    }];
    
    self.petkind = [[UILabel alloc]init];
    self.petkind.backgroundColor = [UIColor whiteColor];
    self.petkind.text = [NSString stringWithFormat:@"宠物种类:%@",kind];
    [self.view addSubview:self.petkind];
    [self.petkind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.petsex.mas_bottom).with.offset(20);
    }];
    
    self.petbirth = [[UILabel alloc]init];
    self.petbirth.backgroundColor = [UIColor whiteColor];
    self.petbirth.text = [NSString stringWithFormat:@"宠物生日:%@",birth];
    [self.view addSubview:self.petbirth];
    [self.petbirth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.petkind.mas_bottom).with.offset(20);
    }];
    
    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.saveBtn];
    self.saveBtn.backgroundColor = [UIColor redColor];
    [self.saveBtn setTitle:@"添加闹钟提醒" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 30));
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.petbirth.mas_bottom).with.offset(40);
    }];
    [self.saveBtn addTarget:self action:@selector(localNotic:) forControlEvents:UIControlEventTouchDown];
}

- (void)localNotic:(UIButton *)bt {
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"Clock-alarm://"]];

}


- (void)creatTableView {
    
    
    self.avatar = [[UIImageView alloc]init];
    [self.view addSubview:self.avatar];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImg)];
    self.avatar.userInteractionEnabled = YES;
    [self.avatar addGestureRecognizer:tap];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    NSLog(@"图片路径:%@", fullPath);
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.left.equalTo(self.view).with.offset(SCREEN_WIDTH / 2 - 35);
        make.top.equalTo(self.view.mas_top).with.offset(100);
    }];
    self.avatar.layer.cornerRadius = 35;
    self.avatar.layer.masksToBounds = YES;
    [self.avatar sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"EaseUIResource.bundle/user"]];
    
    UIView *view2 = [[UIView alloc]init];
    [self.view addSubview:view2];
    view2.backgroundColor = [UIColor whiteColor];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 193));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(20);
    }];

    
    
    self.petname = [[UILabel alloc]init];
    self.petname.backgroundColor = [UIColor whiteColor];
    self.petname.text = @"宠物昵称";
    self.petname.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:self.petname];
    [self.petname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(view2).with.offset(0);
        make.top.equalTo(view2.mas_top).with.offset(3);
    }];
    
    self.namebut = [UIButton buttonWithType:UIButtonTypeCustom];
    [view2 addSubview:self.namebut];
    [self.namebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 40));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(view2.mas_top).with.offset(3);
    }];
    [self.namebut setTitle:@"设置宠物昵称" forState:UIControlStateNormal];
    [self.namebut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.namebut addTarget:self action:@selector(setname) forControlEvents:UIControlEventTouchDown];
    
    
    
    
    
    UIView *view3 = [[UIView alloc]init];
    [view2 addSubview:view3];
    view3.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(self.namebut.mas_bottom).with.offset(5);
    }];
    
    
    //sex
    self.petsex = [[UILabel alloc]init];
    self.petsex.backgroundColor = [UIColor whiteColor];
    self.petsex.text = @"宠物性别";
    self.petsex.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:self.petsex];
    [self.petsex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(view2).with.offset(0);
        make.top.equalTo(view3.mas_bottom).with.offset(3);
    }];
    
    self.sexbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [view2 addSubview:self.sexbut];
    [self.sexbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 40));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(view3.mas_top).with.offset(3);
    }];
    [self.sexbut setTitle:@"性别" forState:UIControlStateNormal];
    [self.sexbut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.sexbut addTarget:self action:@selector(setsex:) forControlEvents:UIControlEventTouchDown];
    
    UIView *view4 = [[UIView alloc]init];
    [view2 addSubview:view4];
    view4.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(self.sexbut.mas_bottom).with.offset(5);
    }];

    
    //kind
    self.petkind = [[UILabel alloc]init];
    self.petkind.backgroundColor = [UIColor whiteColor];
    self.petkind.text = @"宠物种类";
    self.petkind.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:self.petkind];
    [self.petkind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(view2).with.offset(0);
        make.top.equalTo(view4.mas_bottom).with.offset(3);
    }];
    
    self.kindbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [view2 addSubview:self.kindbut];
    [self.kindbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 40));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(view4.mas_top).with.offset(3);
    }];
    [self.kindbut setTitle:@"选择宠物种类" forState:UIControlStateNormal];
    [self.kindbut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.kindbut addTarget:self action:@selector(setkind:) forControlEvents:UIControlEventTouchDown];
    
    UIView *view5 = [[UIView alloc]init];
    [view2 addSubview:view5];
    view5.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(self.kindbut.mas_bottom).with.offset(5);
    }];
    
    //birth
    self.petbirth = [[UILabel alloc]init];
    self.petbirth.backgroundColor = [UIColor whiteColor];
    self.petbirth.text = @"宠物生日";
    self.petbirth.textAlignment = NSTextAlignmentLeft;
    [view2 addSubview:self.petbirth];
    [self.petbirth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.left.equalTo(view2).with.offset(0);
        make.top.equalTo(view5.mas_bottom).with.offset(3);
    }];
    
    self.birthbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [view2 addSubview:self.birthbut];
    [self.birthbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190, 40));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(view5.mas_top).with.offset(3);
    }];
    [self.birthbut setTitle:@"选择宠物生日" forState:UIControlStateNormal];
    [self.birthbut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.birthbut addTarget:self action:@selector(setbirth:) forControlEvents:UIControlEventTouchDown];
    
    UIView *view6 = [[UIView alloc]init];
    [view2 addSubview:view6];
    view6.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    [view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.right.equalTo(view2.mas_right).with.offset(0);
        make.top.equalTo(self.birthbut.mas_bottom).with.offset(5);
    }];

    
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.saveBtn];
    self.saveBtn.backgroundColor = [UIColor redColor];
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 20, 30));
        make.right.equalTo(view2.mas_right).with.offset(-10);
        make.top.equalTo(view2.mas_bottom).with.offset(10);
    }];
    [self.saveBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchDown];
    
}

- (void)setname {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.namebut setTitle:[weakAlert.textFields.firstObject text] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = @"输入昵称";

    }];

    
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)saveInfo {
    BmobUser *user = [BmobUser currentUser];
    [user setObject:self.namebut.currentTitle forKey:@"petName"];
    [user setObject:self.kindbut.currentTitle forKey:@"petKind"];
    [user setObject:self.birthbut.currentTitle forKey:@"petBirth"];
    [user setObject:self.sexbut.currentTitle forKey:@"petSex"];
    [user setObject:@1 forKey:@"has_pet"];

    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (!error) {
            NSLog(@"保存成功");
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            NSLog(@"%@", error);
        }
    }];


}




- (void)setsex:(UIButton *)bt {
    LEActionSheet *actionSheet = [[LEActionSheet alloc] initWithTitle:@"请选择宠物性别"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"male"
                                                    otherButtonTitles:@[@"female"]];
    [actionSheet showInView:self.view.window];
}


-(void)actionSheet:(LEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.sexbut setTitle:@"male" forState:UIControlStateNormal];
    }else if (buttonIndex == 1) {
        [self.sexbut setTitle:@"female" forState:UIControlStateNormal];
    }
}


- (void)setkind:(UIButton *)bt {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入种类" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.kindbut setTitle:[weakAlert.textFields.firstObject text] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = @"输入种类";
        
    }];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)setbirth:(UIButton *)bt {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入生日" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.birthbut setTitle:[weakAlert.textFields.firstObject text] forState:UIControlStateNormal];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = @"输入生日";
        
    }];
    
    
    [self presentViewController:alert animated:YES completion:nil];
  
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
