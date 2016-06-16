//
//  ViewController.m
//  二维码扫描(原生)
//
//  Created by vcyber on 16/6/15.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MyViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanView.h"

static const char *kScanQRCodeQueueName = "ScanQRCodeQueueName";

@interface MyViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) BOOL lastResult;

/**
 *  扫描视图
 */
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;

@property (nonatomic, strong) ScanView *scanView;
@end



@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scanView  = [[ScanView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _scanView.center = self.view.center;
    [self.view addSubview:_scanView];
    _lastResult = YES;
    
}


- (BOOL)startReading {
    
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"初始化输入失败---%@", error.localizedDescription);
        return NO;
    }
    
    //创建会话
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPreset640x480; //这个尺寸够用 如果扫描图片较小设置高的就行
    //添加输入流
    [_session addInput:input];
    //初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //添加输出流
    [_session addOutput:captureMetadataOutput];
    
    //创建线程队列
    dispatch_queue_t dispathQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispathQueue];
    
    //设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:CGRectMake(LINEWIDTH, LINEWIDTH, _scanView.frame.size.width - LINEWIDTH * 2, _scanView.frame.size.height - LINEWIDTH * 2)];
    [_scanView.layer addSublayer:_videoPreviewLayer];
    
    //开始会话
    [_session startRunning];
    return YES;
}


- (void)stopReading {
    
    [_session stopRunning];
    _session = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}


/**
 *  系统照明灯控制
 */
- (void)systemLightSwitch:(BOOL)open {
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if ([device hasTorch]) {
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
            
        }else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        
        [device unlockForConfiguration];
    }
    
}


- (IBAction)openLighter:(UIButton *)sender {
    
    sender.selected = !sender.selected;
     [self systemLightSwitch:sender.selected];
}

- (IBAction)scan:(UIButton *)sender {
    
    if (sender.selected) {
        [self stopReading];
    }else{

        [self startReading];
    }
    
    sender.selected = !sender.selected;
}


#pragma mark ----AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil && metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        }else {
            NSLog(@"不是二维码");
        }
        
        [self performSelectorOnMainThread:@selector(showScanResult:) withObject:result waitUntilDone:NO];
    }
    
}

- (void)showScanResult:(NSString *)result {
    _scanBtn.selected = NO;
    [self stopReading];
    if (!_lastResult) {
        return;
    }else {
        
        NSLog(@"扫描结果:%@", result);
         _lastResult = YES;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
