//
//  ToViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/8/5.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "ToViewController.h"

@interface ToViewController ()

@end

@implementation ToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.3373 green:0.8809 blue:0.9846 alpha:1.0];
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(20, 80, 80, 60);
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.backgroundColor = [UIColor cyanColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    dismissButton.titleLabel.numberOfLines = 0;
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
}
- (void)dismiss:(UIButton *)sender
{
    if ([self.type isEqualToString:@"push"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];}
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
