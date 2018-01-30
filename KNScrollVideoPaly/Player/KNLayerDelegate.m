//
//  KNLayerDelegate.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNLayerDelegate.h"

@implementation KNLayerDelegate


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    CGMutablePathRef maxPath = CGPathCreateMutable();
    CGPathMoveToPoint(maxPath, NULL, panDistance + self.sliderDiameter, self.centerY);
    CGPathAddLineToPoint(maxPath, nil, self.lineLength, self.centerY);
    CGContextSetStrokeColorWithColor(ctx, self.maxColor.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextAddPath(ctx, maxPath);
    CGPathCloseSubpath(maxPath);
    CGContextStrokePath(ctx);
    CGPathRelease(maxPath);
    
    CGMutablePathRef middlePath = CGPathCreateMutable();
    CGPathMoveToPoint(middlePath, NULL, 0, self.centerY);
    CGPathAddLineToPoint(middlePath, nil, self.middleValue * self.lineLength, self.centerY);
    CGContextSetStrokeColorWithColor(ctx, self.middleColor.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextAddPath(ctx, middlePath);
    CGPathCloseSubpath(middlePath);
    CGContextStrokePath(ctx);
    CGPathRelease(middlePath);
    
    CGMutablePathRef minPath = CGPathCreateMutable();
    CGPathMoveToPoint(minPath, NULL, 0, self.centerY);
    CGPathAddLineToPoint(minPath, nil, panDistance, self.centerY);
    CGContextSetStrokeColorWithColor(ctx, self.minColor.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
    CGContextAddPath(ctx, minPath);
    CGPathCloseSubpath(minPath);
    CGContextStrokePath(ctx);
    CGPathRelease(minPath);
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    CGPathAddEllipseInRect(pointPath, nil, CGRectMake(panDistance, self.centerY - (self.sliderDiameter / 2), self.sliderDiameter, self.sliderDiameter));
    CGContextSetFillColorWithColor(ctx, self.sliderColor.CGColor);
    CGContextAddPath(ctx, pointPath);
    CGPathCloseSubpath(pointPath);
    CGContextFillPath(ctx);
    CGPathRelease(pointPath);
}

@end
