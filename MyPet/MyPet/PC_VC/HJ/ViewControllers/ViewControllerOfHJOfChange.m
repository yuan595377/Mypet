//
//  ViewControllerOfHJOfChange.m
//  Program
//
//  Created by Jasmine on 16/5/19.
//  Copyright © 2016年 XuRui. All rights reserved.
//

#import "ViewControllerOfHJOfChange.h"
#import "CollectionViewCellOfHjOfPicture.h"
#import "CollectionReusableViewOfHJOfHeader.h"

@interface ViewControllerOfHJOfChange ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonnull, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *mArr;// 第一分区图片(方块)数组
@property (nonatomic, strong) NSMutableArray *mArrOfStart;// 第二分区(星球)图片数组
@property (nonatomic, strong) UILabel *viewOfRemind;// 完成label
@property (nonatomic, strong) NSString *path;// 系统相册路径

@end

@implementation ViewControllerOfHJOfChange

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.mArr = [NSMutableArray array];
    self.mArrOfStart = [NSMutableArray array];
    
    
    [self createImageView];
    [self handleData];
    
    
}
- (void)handleData
{
    // 方块数组
    for (NSInteger i = 1; i <= 9; i++) {
        NSString *str = [NSString stringWithFormat:@"H%ld", i];
       
        [self.mArr addObject:str];
    }
    // 星球数组
    for (NSInteger i = 20; i <= 28; i++) {
        NSString *str = [NSString stringWithFormat:@"H%ld", i];
        [self.mArrOfStart addObject:str];
    }
    
}

- (void)createImageView
{
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    _imageView.image = [UIImage imageNamed:@"H6"];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    
    // 毛玻璃
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    // 创建视图添加效果
    UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:effect];
    view.frame = _imageView.frame;
    [self.imageView addSubview:view];
    // 返回上一页面button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 70, 30);
    [_imageView addSubview:button];
    [button setTitle:@"X 关闭" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(cha:) forControlEvents:UIControlEventTouchUpInside];
    // 标题
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(160, 25, 40, 25)];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    label.text = @"壁纸";
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 40 - 1) / 3 , 150);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 25) collectionViewLayout:flowLayout];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CollectionViewCellOfHjOfPicture class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    // 头部
    [_collectionView registerClass:[CollectionReusableViewOfHJOfHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
#pragma mark - 头部高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 105);
}
#pragma mark - 分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
    
}
#pragma mark - item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellOfHjOfPicture *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // 第一分区图片
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:self.mArr[indexPath.row]];
        cell.imageViewOfSelected.hidden = YES;
        cell.labelOfSelected.hidden = YES;
        if (indexPath.row == 8) {
            cell.imageViewOfSelected.hidden = NO;
            cell.labelOfSelected.hidden = NO;
            cell.labelOfSelected.text = @"自定义";
            cell.imageViewOfSelected.image = [UIImage imageNamed:@"jia"];

        }
        // 第二分区 图片
    }else {
        cell.imageView.image = [UIImage imageNamed:self.mArrOfStart[indexPath.row]];
    }
    
    return cell;
}
#pragma mark - 返回上一页
- (void)cha:(UIButton *)cha
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 头部试图协议方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableViewOfHJOfHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.labelOfTittle.text = @"SPACE CUBE";
            header.labelOfType.text = @"宇宙方块";
            header.labelOfNumber.text = @"_01";
            header.imageView.image = [UIImage imageNamed:@"l"];
        }else{
            header.labelOfTittle.text = @"PIXEL PLANET";
            header.labelOfType.text = @"像素星球";
            header.labelOfNumber.text = @"_02";
            header.imageView.image = [UIImage imageNamed:@"start"];
        }
        return header;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row != 8) {
            // 调用block
            self.passValue(self.mArr[indexPath.item]);
            [self remind];
            [self performSelector:@selector(dismiss) withObject:self
                       afterDelay:0.3];
        }
        if (indexPath.row == 8) {
            [self getImage];
        }
    }else {
        // 调用block
        self.passValue(self.mArrOfStart[indexPath.item]);
        [self remind];
        [self performSelector:@selector(dismiss) withObject:self
                   afterDelay:0.3];
        
    }
}
#pragma mark - 图片设置成功提醒
- (void)remind
{
    
    [UIView animateWithDuration:0.0 animations:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewOfRemind = [[UILabel alloc]initWithFrame:CGRectMake(180 * SCALEWIDTH, 650 * SCALEHEIGHT, 50 * SCALEWIDTH, 40 * SCALEHEIGHT)];
            [self.view addSubview:_viewOfRemind];
            _viewOfRemind.backgroundColor = [UIColor grayColor];
            _viewOfRemind.text = @"完成";
            _viewOfRemind.textAlignment = YES;
            _viewOfRemind.layer.cornerRadius = 10;
            _viewOfRemind.clipsToBounds = YES;
            _viewOfRemind.textColor = [UIColor whiteColor];
        });
    } completion:^(BOOL finished) {
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [_viewOfRemind removeFromSuperview];
        });
        
    }];
    
}
#pragma mark - 获取系统相册图片
- (void)getImage
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    // 静态方法判断设备是否支持图库功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    picker.delegate = self;
    // 是否编辑
    picker.allowsEditing = YES;
    // 跳转到对应界面
    [self presentViewController:picker animated:YES completion:^{
    }];
    
}
#pragma mark - 相册协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 将编辑后的图片保存在image中
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 图片不为空时 显示保存图片
    if (image != nil) {
        // 传递图片 调用block
        self.passImage(image);
        // 把图片转成NSDATA类型的数据来保存文件
        // 判断图片是不是png格式的文件
        NSData *data;
        if (UIImagePNGRepresentation(image)) {
            data = UIImagePNGRepresentation(image);
        }else {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        // 保存
        [[NSFileManager defaultManager]createFileAtPath:self.path contents:data attributes:nil];
        // 保存当前图片
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:data forKey:@"image"];
        [self dismissViewControllerAnimated:YES completion:^{
            
            [self performSelector:@selector(dismiss) withObject:self
                       afterDelay:0.0];
            
        }];
        
    }
    
}
- (void)dismiss
{
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
