//
//  AvatarVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/23.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "AvatarVC.h"

@interface AvatarVC ()<LEActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, retain)UIImageView *im;
@end

@implementation AvatarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    // Do any additional setup after loading the view.

    [self setAvatar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *but = [[UIBarButtonItem alloc]initWithTitle:@"更换头像" style:UIBarButtonItemStylePlain target:self action:@selector(jumpAvatar)];
    [but setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = but;

    
  
}




- (void)setAvatar {
    self.im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.im.center = self.view.center;
    [self.view addSubview:self.im];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    NSLog(@"图片路径:%@", fullPath);
    [self.im sd_setImageWithURL:[NSURL fileURLWithPath:fullPath] placeholderImage:[UIImage imageNamed:@"112.jpeg"]];
    
    

}

- (void)jumpAvatar {
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
    [self saveImage:newPhoto withName:@"avatar.png"];
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
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"infoAvatar"];
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:fullPath];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
            [obj setObject:file1  forKey:@"img"];
            [obj setObject:file1.url forKey:@"avatar"];
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
