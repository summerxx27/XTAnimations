//
//  XTPictureViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/8/15.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTPictureViewController.h"
#import "XTThumbUpAnimation.h"

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
    XTThumbUpAnimation *heart = [[XTThumbUpAnimation alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
    heart.center = fountainSource;
    int count = round(random() % 12);
    [heart animatePictureInView:self.view Image:[UIImage imageNamed:[NSString stringWithFormat:@"resource.bundle/heart%d.png",count]]];
}

@end
