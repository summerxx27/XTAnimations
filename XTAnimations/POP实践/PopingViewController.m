//
//  PopingViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/29.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "PopingViewController.h"
#import "XTPopingView.h"
@interface PopingViewController ()

@end

@implementation PopingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.center.x - 50, 84, 100, 50);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(self.view.center.x - 50, 84 + 60, 100, 50);
    btn1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(clickTwo:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)click:(UIButton *)btn
{
    XTPopingView *view = [[XTPopingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.fly_h = 350;
    view.fly_w = 250;
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.fly_w, view.fly_h)];
    headerImage.image = [UIImage imageNamed:@"chenyao.jpg"];
    
    [self.view addSubview:view];
    [view.flyView addSubview:headerImage];
    [view startFly:FlyTypeUToD];
}

- (void)clickTwo:(UIButton *)btn
{
    XTPopingView *view = [[XTPopingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.fly_h = 350;
    view.fly_w = 250;
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.fly_w, view.fly_h)];
    headerImage.image = [UIImage imageNamed:@"chenyao2.jpg"];
    
    [self.view addSubview:view];
    [view.flyView addSubview:headerImage];
    [view startFly:FlyTypeDToD];
}


@end
