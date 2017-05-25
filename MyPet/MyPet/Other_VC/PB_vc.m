//
//  PB_vc.m
//  MyPet
//
//  Created by 袁立康 on 17/4/16.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "PB_vc.h"

@interface PB_vc ()<UITextViewDelegate,LEActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain)UIButton *button_login;
@property (nonatomic, retain)UITextView *textView;
@property (nonatomic, retain)UIButton *button_close;
@property (nonatomic, retain)UIImageView *im;
@property (nonatomic, retain)BmobObject *obj;
@property (nonatomic, retain)NSString *url;


@end

@implementation PB_vc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, [UIScreen mainScreen].bounds.size.height - 400) textContainer:nil];
    _textView.textColor = [UIColor blueColor];
    _textView.font = [UIFont systemFontOfSize:15.0];
    _textView.backgroundColor = [UIColor cyanColor];
    _textView.opaque = YES;
    _textView.alpha = 1.0;
    _textView.delegate = self;
//    _textView.tag = VALUE_LABEL_TAG;
    _textView.layer.cornerRadius = 8;
    _textView.clipsToBounds = YES;
//    _textView.text = self.chatBody;
    _textView.textAlignment = UITextAlignmentLeft;
    _textView.editable = YES;
    _textView.scrollEnabled = YES;
    [_textView becomeFirstResponder];
    [self.view addSubview: _textView];
    
    _im = [[UIImageView alloc]init];
    [self.view addSubview:_im];
    _im.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImg)];
    [_im addGestureRecognizer:tap];
    _im.backgroundColor = [UIColor cyanColor];
    [self.im mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(self.textView.mas_bottom).with.offset(3);
    }];
    
    
    
    //login
    self.button_login = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_login];
    [self.button_login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button_login.layer.borderWidth=1;//设置边框的宽度
    self.button_login.layer.cornerRadius = 8;
    self.button_login.layer.masksToBounds = YES;
    self.button_login.layer.borderColor=[[UIColor redColor]CGColor];
    [self.button_login setTitle:@"发送" forState:UIControlStateNormal];
    [self.button_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.top.equalTo(self.view.mas_top).with.offset(30);
    }];
    [self.button_login addTarget:self action:@selector(loginUser) forControlEvents:UIControlEventTouchDown];
    
    self.button_close = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.button_close];
    [self.button_close setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.button_close setTitle:@"试用" forState:UIControlStateNormal];
    [self.button_close setImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
    self.button_close.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.left.equalTo(self.view).with.offset(10);
        make.top.equalTo(self.view).with.offset(30);
    }];
    
    [self.button_close addTarget:self action:@selector(try) forControlEvents:UIControlEventTouchDown];
    
    
}

- (void)try {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)loginUser {
    //创建BmobObject对象，指定对应要操作的数据表名称
    _obj = [[BmobObject alloc] initWithClassName:STOREAGE_INFO];
    //设置字段值
    [_obj setObject:_textView.text forKey:@"title"];
    [_obj setObject:[EMClient sharedClient].currentUsername forKey:@"user_id"];
    [_obj setObject:self.url forKey:@"PubImg"];
    
    
    //执行保存操作
    [_obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        if (!error) {
            //其他代码
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [SVProgressHUD setMinimumDismissTimeInterval:1];
            [self dismissViewControllerAnimated:YES completion:nil];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[DLTabBarController alloc]init];
        }
        
    }];

}


- (void)jumpAvatar {
    [self.textView resignFirstResponder];
    LEActionSheet *actionSheet = [[LEActionSheet alloc] initWithTitle:@"点击更换头像"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"从相册选择"
                                                    otherButtonTitles:@[@"拍照"]];
    [actionSheet showInView:self.view.window];
}

-(void)actionSheet:(LEActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self chooseImg];
    }
}


#pragma mark ----相册选择照片
- (void)chooseImg {
    [self.textView resignFirstResponder];

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
    self.im.image = newPhoto;
    [self saveImage:newPhoto withName:@"pubImg.png"];
    //关闭当前界面，即回到主界面去
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 保存图片至本地沙盒

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    [self saveBackGroundAvatar];
}

- (void)saveBackGroundAvatar {
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"pubImg.png"];
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:fullPath];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
            self.url = file1.url;
            //此处相当于新建一条记录,         //关联至已有的记录请使用 [obj updateInBackground];
            [_obj saveInBackground];
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
