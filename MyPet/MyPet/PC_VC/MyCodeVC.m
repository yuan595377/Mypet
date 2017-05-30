//
//  MyCodeVC.m
//  MyPet
//
//  Created by 袁立康 on 17/4/22.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "MyCodeVC.h"

@interface MyCodeVC ()
@property (nonatomic, retain)UIImageView *codeImg;
@end

@implementation MyCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self createSub];
    self.view.backgroundColor = [UIColor whiteColor];
    
}



- (void)createSub {
    self.codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:_codeImg];
    self.codeImg.center = self.view.center;
    
    //生成二维码图片
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.恢复滤镜的默认属性（因为滤镜有可能保存上一次的属性）
    [filter setDefaults];
    //3.经字符串转化成NSData
    NSData *data = [[EMClient sharedClient].currentUsername dataUsingEncoding:NSUTF8StringEncoding];
    //4.通过KVC设置滤镜，传入data，将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    //5.生成二维码
    CIImage *image = [filter outputImage];
    //CIImage是CoreImage框架中最基本代表图像的对象，他不仅包含元图像数据，还包含作用在原图像上的滤镜链。
    self.codeImg.image = [UIImage imageWithCIImage:image];
    self.codeImg.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:100.0];
    
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    //设置比例
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap（位图）;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
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
