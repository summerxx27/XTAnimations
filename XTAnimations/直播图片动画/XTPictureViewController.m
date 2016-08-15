//
//  XTPictureViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/8/15.
//  Copyright © 2016年 夏天然后. All rights reserved.
//
#import "XTLikePictureView.h"
#import "XTPictureViewController.h"
#define s_w [UIScreen mainScreen].bounds.size.width
#define s_h [UIScreen mainScreen].bounds.size.height

@implementation XTPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"darong"];
    [self.view addSubview:imageView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(showLoveHeartView) userInfo:nil repeats:YES];
    
}
- (void)showLoveHeartView
{
    XTLikePictureView *heart = [[XTLikePictureView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
    heart.center = fountainSource;
    int count = round(random() % 12);
    [heart animatePictureInView:self.view Image:[UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/heart%d.png",count]]];
}

@end
