//
//  ScanView.m
//  二维码综合
//
//  Created by vcyber on 16/6/15.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ScanView.h"

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat angleLength = 20;
    
    CGFloat lineWidth = LINEWIDTH;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint topLeft = self.bounds.origin;
    CGPoint topRight = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y);
    CGPoint bottomLeft = CGPointMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height);
    CGPoint bottomRight = CGPointMake(self.bounds.origin.x + self.bounds.size.width, self.bounds.origin.y + self.bounds.size.height);
    
    //画方框
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect retangle = CGRectMake(lineWidth, lineWidth, self.frame.size.width - lineWidth * 2, self.frame.size.height - lineWidth * 2);
    CGPathAddRect(path, NULL, retangle);
    CGContextAddPath(context, path);
    [[UIColor yellowColor] setStroke];
    CGContextSetLineWidth(context, lineWidth);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 2);
    
    
    //左上水平线
    CGContextMoveToPoint(context, topLeft.x, topLeft.y);
    CGContextAddLineToPoint(context, topLeft.x + angleLength, topLeft.y);
    
    //左上垂直线
    CGContextMoveToPoint(context, topLeft.x, topLeft.y);
    CGContextAddLineToPoint(context, topLeft.x, topLeft.y + angleLength);
    
    CGContextStrokePath(context);
}

@end
