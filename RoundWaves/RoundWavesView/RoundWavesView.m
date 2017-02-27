//
//  RoundWavesView.m
//  RoundWaves
//
//  Created by haogaoming on 2017/2/24.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "RoundWavesView.h"

@interface RoundWavesView ()

/**
 主layer，用于渐变色layer
 */
@property (nonatomic,strong) CAGradientLayer     *gradientLayer;

/**
 辅助layer，用于复制子layer
 */
@property (nonatomic,strong) CAReplicatorLayer   *replicatorLayer;

/**
 子layer，圈圈layer
 */
@property (nonatomic,strong) CAShapeLayer        *shapeLayer;
@end

@implementation RoundWavesView

/**
  主layer，用于渐变

 @return 渐变的layer
 */
-(CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        
        [self.layer addSublayer:_gradientLayer];
    }
    return _gradientLayer;
}

/**
  辅助的layer,用于复制圈圈layer

 @return 辅助layer
 */
-(CAReplicatorLayer *)replicatorLayer
{
    if (_replicatorLayer == nil) {
        _replicatorLayer = [CAReplicatorLayer layer];
    }
    return _replicatorLayer;
}

/**
  子layer，画圆圈

 @return 画圈圈的layer
 */
-(CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _shapeLayer;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        //主layer，用于渐变
        self.gradientLayer.mask = self.replicatorLayer;

        //子layer，画圆圈
        [self.replicatorLayer addSublayer:self.shapeLayer];
        
        self.minRadius = 10;
        self.maxRadius = 50;
        
        self.count = 6;
        self.duration = 3.0f;
        self.lineWidth = 2.0f;
        
        self.colors = @[(__bridge id)[UIColor colorWithRed:0.996 green:0.647 blue:0.008 alpha:1].CGColor,(__bridge id)[UIColor colorWithRed:1 green:0.31 blue:0.349 alpha:1].CGColor];
        self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    }
    return self;
}

- (void)startAnimation
{
    CGRect fromRect = CGRectMake(CGRectGetMidX(self.bounds)-self.minRadius, CGRectGetMidY(self.bounds)-self.minRadius, self.minRadius*2, self.minRadius*2);
    CGRect toRect   = CGRectMake(CGRectGetMidX(self.bounds)-self.maxRadius, CGRectGetMidY(self.bounds)-self.maxRadius, self.maxRadius*2, self.maxRadius*2);
    
    CABasicAnimation *zoomAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    zoomAnimation.duration          = self.duration;
    zoomAnimation.fromValue         = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:fromRect].CGPath;
    zoomAnimation.toValue           = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:toRect].CGPath;
    zoomAnimation.repeatCount       = HUGE_VAL;
    zoomAnimation.timingFunction    = self.timingFunction;
    [self.shapeLayer addAnimation:zoomAnimation forKey:@"zoom"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    fadeAnimation.duration          = self.duration;
    fadeAnimation.fromValue         = (__bridge id)[UIColor whiteColor].CGColor;
    fadeAnimation.toValue           = (__bridge id)[UIColor clearColor].CGColor;
    fadeAnimation.repeatCount       = HUGE_VAL;
    fadeAnimation.timingFunction    = self.timingFunction;
    [self.shapeLayer addAnimation:fadeAnimation forKey:@"fade"];
    
    /**************************************提供两种不同的动画供参考**************************************/
    /*
    //变大动画
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    transform.duration          = self.duration;
    transform.fromValue         = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    transform.toValue           = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2, 2, 2)];
    transform.repeatCount       = HUGE_VAL;
    transform.timingFunction    = self.timingFunction;
    [self.shapeLayer addAnimation:transform forKey:@"scale"];
    
    //变透明动画
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.duration          = self.duration;
    opacity.fromValue         = [NSNumber numberWithDouble:1];
    opacity.toValue           = [NSNumber numberWithDouble:0];
    opacity.repeatCount       = HUGE_VAL;
    opacity.timingFunction    = self.timingFunction;
    [self.shapeLayer addAnimation:opacity forKey:@"opacity"];
    */
}

- (void)stopAnimation
{
    [self.shapeLayer removeAllAnimations];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = self.bounds;
    self.replicatorLayer.frame = self.bounds;
    self.shapeLayer.frame = self.bounds;
}

/**
 设置渐变色的数组
 
 @param colors 数组
 */
- (void)setColors:(NSArray *)colors
{
    self.gradientLayer.colors = colors;
}
- (NSArray *)colors
{
    return  self.gradientLayer.colors;
}

/**
 设置渐变色的开始位置
 
 @param startPoint 开始位置
 */
- (void)setStartPoint:(CGPoint)startPoint
{
    self.gradientLayer.startPoint = startPoint;
}
- (CGPoint)startPoint
{
    return self.gradientLayer.startPoint;
}

/**
 设置渐变色的结束位置
 
 @param endPoint 结束位置
 */
- (void)setEndPoint:(CGPoint)endPoint
{
    self.gradientLayer.endPoint = endPoint;
}
- (CGPoint)endPoint
{
    return  self.gradientLayer.endPoint;
}

/**
 设置子layer的个数

 @param count 个数
 */
- (void)setCount:(NSUInteger)count
{
    _count = count;
    
    if (_count != 0) {
        self.replicatorLayer.instanceCount = _count;
        self.replicatorLayer.instanceDelay = _duration/(CGFloat)_count;
    }
}

/**
 设置动画的时间间隔

 @param duration 时间间隔
 */
- (void)setDuration:(CGFloat)duration
{
    _duration = duration;
    
    if (_count != 0) {
        self.replicatorLayer.instanceCount = _count;
        self.replicatorLayer.instanceDelay = _duration/(CGFloat)_count;
    }
}

/**
 设置线条的宽度

 @param lineWidth 线条的宽度
 */
- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    self.shapeLayer.lineWidth = lineWidth;
}
@end

