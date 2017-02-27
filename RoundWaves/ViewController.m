//
//  ViewController.m
//  RoundWaves
//
//  Created by haogaoming on 2017/2/24.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "ViewController.h"
#import "RoundWavesView.h"

@interface ViewController ()

@end

@implementation ViewController

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
