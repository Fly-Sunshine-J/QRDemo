//
//  QRImageViewController.m
//  二维码综合
//
//  Created by vcyber on 16/6/16.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "QRImageViewController.h"
#import "QRImage.h"

@interface QRImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *qrImageVIew;

@end

@implementation QRImageViewController

- (void)viewDidLoad {
    
    _qrImageVIew.image = [QRImage createQRWithString:_str size:CGSizeMake(200, 200)];
    
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
