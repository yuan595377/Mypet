//
//  ScanVc.m
//  MyPet
//
//  Created by 袁立康 on 17/4/22.
//  Copyright © 2017年 袁立康. All rights reserved.
//

#import "ScanVc.h"
#import <AVFoundation/AVFoundation.h>
@interface ScanVc ()<AVCaptureMetadataOutputObjectsDelegate>


@property (strong,nonatomic)AVCaptureDevice * device;
//是AVCaptureInput的子类,可以作为输入捕获会话，用AVCaptureDevice实例初始化。
@property (strong,nonatomic)AVCaptureDeviceInput * input;
//是AVCaptureOutput的子类，处理输出捕获会话
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
//管理输入(AVCaptureInput)和输出(AVCaptureOutput)流，包含开启和停止会话方法。
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, assign)BOOL lastResult;

@end

@implementation ScanVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Device
    self.view.backgroundColor = [UIColor whiteColor];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //连接输入和输出
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    
    //设置条形码类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //添加扫描画面
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //相机范围.
    _preview.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 150, [UIScreen mainScreen].bounds.size.height / 2 - 175, 300, 350);
    [self.view.layer insertSublayer:_preview atIndex:0];
    [_session startRunning];
    
}

- (void)stopReading {
    [_session stopRunning];
    _session = nil;
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
            //实现页面跳转.
            chatVC *vc = [[chatVC alloc]initWithConversationChatter:result conversationType:EMConversationTypeChat];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"扫描错误"];
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}

- (void)reportScanResult:(NSString *)result {
    [self stopReading];
    if (!_lastResult) {
        _lastResult = NO;
        
        return;
    }
    else{
        //以下处理了结果,继续下次扫描
        _lastResult = YES;
        
    }
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
