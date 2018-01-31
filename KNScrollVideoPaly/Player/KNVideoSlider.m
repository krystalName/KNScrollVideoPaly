//
//  KNVideoSlider.m
//  KNScrollVideoPaly
//
//  Created by 刘凡 on 2018/1/30.
//  Copyright © 2018年 leesang. All rights reserved.
//

#import "KNVideoSlider.h"
#import "KNLayerDelegate.h"

@interface KNVideoSlider()
{
    CALayer *_lienLayer;
    KNLayerDelegate *_delegate;
}

@end

@implementation KNVideoSlider

- (instancetype)init
{
    self = [super init];
    if (self) {
        ///添加一个拖动手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:panGesture];
        ///添加一个点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        ///手势共存
        [tapGesture requireGestureRecognizerToFail:panGesture];
        ///创建代理
        _delegate = [[KNLayerDelegate alloc]init];
        _delegate.maxColor = self.maxColor;
        _delegate.middleColor = self.middleColor;
        _delegate.minColor = self.minColor;
        _delegate.sliderDiameter = self.sliderDiameter;
        _delegate.sliderColor = self.sliderColor;
        _delegate.lineWidth = self.lineWidth;
        
        _lienLayer = [CALayer layer];
        _lienLayer.delegate = _delegate;
        [self.layer addSublayer:_lienLayer];
        [_lienLayer setNeedsDisplay];
        
        [self addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"middleValue" options:NSKeyValueObservingOptionNew context:nil];
    
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    _delegate.centerY = self.frame.size.height/2.0f;
    _delegate.lineLength = self.frame.size.width;
    _lienLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_lienLayer setNeedsDisplay];
    
}

#pragma mark - KeyValue实现



#pragma mark - 手势事件
///点击事件的处理
- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    
    ///获取到点击的位置
    CGPoint location = [tapGesture locationInView:self];
    panDistance = location.x;
    //
    self.value =  panDistance / (self.frame.size.width - self.sliderDiameter);
    if (self.finishChangeBlock) {
        self.finishChangeBlock(self);
    }
}

- (void)panAction:(UIPanGestureRecognizer *)panGesture {
    
    CGFloat detalX = [panGesture translationInView:self].x;
    panDistance += detalX;
    //Limited the sliding
    panDistance = panDistance >= 0 ? panDistance : 0;
    panDistance = panDistance <= (self.frame.size.width - self.sliderDiameter) ? panDistance : (self.frame.size.width - self.sliderDiameter);
    [panGesture setTranslation:CGPointZero inView:self];
    self.value = panDistance / (self.frame.size.width - self.sliderDiameter);
    
    if (panGesture.state ==  UIGestureRecognizerStateEnded && self.finishChangeBlock) {
        self.finishChangeBlock(self);
        
    }else if((panGesture.state == UIGestureRecognizerStateChanged || UIGestureRecognizerStateBegan) && self.draggingSliderBlock) {
        self.draggingSliderBlock(self);
    }
}



@end
