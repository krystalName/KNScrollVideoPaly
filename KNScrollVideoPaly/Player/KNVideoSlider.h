//
//  KNVideoSlider.h
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KNVideoSlider;
///滑动时候变化的block
typedef void(^SliderValueChangeBlock)(KNVideoSlider *);
///滑动时第一次改变的Block
typedef void(^SliderFinshChangeBlock)(KNVideoSlider *);
///拖动滑块时的block
typedef void(^DraggingSliderBlock)(KNVideoSlider *);

@interface KNVideoSlider : UIView

///值
@property (nonatomic, assign) CGFloat value;
///最小值
@property (nonatomic, assign) CGFloat middleValue;
///线条宽度
@property (nonatomic, assign) CGFloat lineWidth;
///滑块直径
@property (nonatomic, assign) CGFloat sliderDiameter;
///滑块颜色
@property (nonatomic, strong) UIColor *sliderColor;
///在上面的颜色
@property (nonatomic, strong) UIColor *maxColor;
///中间的颜色
@property (nonatomic, strong) UIColor *middleColor;
///地步时候的颜色
@property (nonatomic, strong) UIColor *minColor;


@property(nonatomic, copy) SliderValueChangeBlock valueChangeBlock;
@property(nonatomic, copy) SliderFinshChangeBlock finshChangeBlock;
@property(nonatomic, strong)DraggingSliderBlock draggingSliderBlock;
@end
