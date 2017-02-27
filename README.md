# RoundWaves
按钮动画，按钮的波纹发散动画

先看效果：
![](https://github.com/haogaoming123/RoundWaves/blob/master/RoundWaves/%E6%8C%89%E9%92%AE%E6%B3%A2%E7%BA%B9%E5%8F%91%E6%95%A3%E6%95%88%E6%9E%9C.png)


使用方法：
```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    RoundWavesView *view = [[RoundWavesView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120, 120, 240, 240)];
    view.tag = 1000;
    [self.view addSubview:view];
    
    CGFloat posY = (self.view.frame.size.height-320)/2/self.view.frame.size.height;
    view.startPoint = CGPointMake(0.5, posY);
    view.endPoint = CGPointMake(0.5, 1.0f - posY);
    
    view.minRadius = 10.6;
    view.maxRadius = 120;
    
    view.count = 4;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)click {
    RoundWavesView *view = (RoundWavesView *)[self.view viewWithTag:1000];
    [view startAnimation];
}
```


主要的代码：
```
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

```
