//
//  QRImage.h
//  二维码综合
//
//  Created by vcyber on 16/6/15.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRImage : NSObject

+ (UIImage *)createQRWithString:(NSString *)str size:(CGSize)size;

@end
