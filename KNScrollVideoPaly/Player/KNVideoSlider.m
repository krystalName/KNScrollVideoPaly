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
    CALayer *_lineLayer;
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
        
        _lineLayer = [CALayer layer];
        _lineLayer.delegate = _delegate;
        [self.layer addSublayer:_lineLayer];
        [_lineLayer setNeedsDisplay];
        
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
    _lineLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_lineLayer setNeedsDisplay];
    
}

#pragma mark - KeyValue实现

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"value"]){
        [_lineLayer setNeedsDisplay];
        if (self.valueChangeBlock) {
            self.valueChangeBlock(self);
        }
    }
    if ([keyPath isEqualToString:@"middleValue"]) {
        [_lineLayer setNeedsDisplay];
    }
}



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

#pragma mark - setter 和 getter

@synthesize sliderColor = _sliderColor;
@synthesize lineWidth = _lineWidth;
@synthesize minColor = _minColor;
@synthesize middleColor = _middleColor;
@synthesize maxColor = _maxColor;
@synthesize sliderDiameter = _sliderDiameter;

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    _delegate.sliderColor = _sliderColor;
}

- (UIColor *)sliderColor {
    if (!_sliderColor) {
        return [UIColor whiteColor];
    }
    return _sliderColor;
}

- (void)setSliderDiameter:(CGFloat)sliderDiameter {
    _sliderDiameter = sliderDiameter;
    _delegate.sliderDiameter = sliderDiameter;
}

- (CGFloat)sliderDiameter {
    if (!_sliderDiameter) {
        return 10.0f;
    }
    return _sliderDiameter;
}

- (void)setMinColor:(UIColor *)minColor {
    _minColor = minColor;
    _delegate.minColor = minColor;
}

- (UIColor *)minColor {
    if (!_minColor) {
        return [UIColor greenColor];
    }
    return _minColor;
}

- (void)setMaxColor:(UIColor *)maxColor {
    _maxColor = maxColor;
    _delegate.maxColor = maxColor;
}

- (UIColor *)maxColor {
    if (!_maxColor) {
        return [UIColor darkGrayColor];
    }
    return _maxColor;
}

- (void)setMiddleColor:(UIColor *)middleColor {
    _middleColor = middleColor;
    _delegate.middleColor = middleColor;
}

- (UIColor *)middleColor {
    if (!_middleColor) {
        return  [UIColor lightGrayColor];
        //        return  [UIColor redColor];
    }
    return _middleColor;
}

- (CGFloat)lineWidth {
    if (!_lineWidth) {
        return 1.0f;
    }
    return _lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    _delegate.lineWidth = lineWidth;
}

-(void)setMiddleValue:(CGFloat)middleValue {
    _middleValue = middleValue;
    _delegate.middleValue = middleValue;
}

- (void)setValue:(CGFloat)value {
    _value = value;
    panDistance = value * (self.frame.size.width - self.sliderDiameter);
}

///删除监听
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"value"];
    [self removeObserver:self forKeyPath:@"middleValue"];
}

@end
