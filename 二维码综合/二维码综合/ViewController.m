//
//  ViewController.m
//  二维码综合
//
//  Created by vcyber on 16/6/15.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "MyViewController.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"gotoQRImageViewController"]) {
        
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"郏飞耀" forKey:@"str"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
