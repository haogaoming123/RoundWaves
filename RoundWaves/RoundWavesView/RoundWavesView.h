//
//  RoundWavesView.h
//  RoundWaves
//
//  Created by haogaoming on 2017/2/24.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundWavesView : UIView
/**
 开始动画
 */
-(void)startAnimation;
/**
 结束动画
 */
-(void)stopAnimation;
@end


/****************************************
 一些属性的设置
 ****************************************/
@interface RoundWavesView ()

//渐变layer的属性
@property (nonatomic,  copy) NSArray    *colors;             ///渐变色数组
@property (nonatomic,assign) CGPoint    startPoint;          ///开始渐变的位置
@property (nonatomic,assign) CGPoint    endPoint;            ///渐变结束的位置

//辅助layer的属性
@property (nonatomic,assign) NSUInteger count;               ///子layer的个数
@property (nonatomic,assign) CGFloat    duration;            ///子layer的动画时间

//子layer的属性
@property (nonatomic,assign) CGFloat    minRadius;           ///圆圈的最小半径
@property (nonatomic,assign) CGFloat    maxRadius;           ///圆圈的最大半径
@property (nonatomic,assign) CGFloat    lineWidth;           ///线的宽度

//速度控制函数
/**
 1.kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
 2.kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
 3.kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
 4.kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为
 */
@property (nonatomic,strong) CAMediaTimingFunction *timingFunction;

@end
