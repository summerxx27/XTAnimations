//
//  XTLoveHeartViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/14.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTLoveHeartViewController.h"
#import "XTLoveHeartView.h"
@interface XTLoveHeartViewController ()

@end

@implementation XTLoveHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"darong"];
    [self.view addSubview:imageView];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(showLoveHeartView) userInfo:nil repeats:YES];
    
}
- (void)showLoveHeartView
{
    XTLoveHeartView *heart = [[XTLoveHeartView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:heart];
    CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
    heart.center = fountainSource;
    [heart animateInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
