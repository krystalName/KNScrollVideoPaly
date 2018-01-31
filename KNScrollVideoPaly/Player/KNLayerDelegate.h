//
//  KNLayerDelegate.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat panDistance;

@interface KNLayerDelegate : NSObject<CALayerDelegate>

@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat middleValue;
@property (nonatomic, assign) CGFloat lineLength;
@property (nonatomic, assign) CGFloat sliderDiameter;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, strong) UIColor *maxColor;
@property (nonatomic, strong) UIColor *middleColor;
@property (nonatomic, strong) UIColor *minColor;

@end
