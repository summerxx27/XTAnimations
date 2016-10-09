//
//  FromViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/8/5.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "FromViewController.h"
#import "DismissAnimator.h"
#import "PresentAnimator.h"
#import "ToViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#warning 暂时不可使用
/// -[UIWindow endDisablingInterfaceAutorotationAnimated:] called on <UIWindow: 0x7fba75004c70; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x608000055db0>; layer = <UIWindowLayer: 0x608000036560>> without matching -beginDisablingInterfaceAutorotation. Ignoring.
@interface FromViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation FromViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // present
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    presentButton.frame = CGRectMake(0, 300, SCREEN_WIDTH, 20);
    [presentButton setTitle:@"Presnet View Controller" forState:UIControlStateNormal];
    [presentButton setTitleColor:[UIColor colorWithRed:0.2912 green:0.904 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(buttonClickPresent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
    
    // push
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushButton.frame = CGRectMake(0, 380, SCREEN_WIDTH, 20);
    [pushButton setTitle:@"Push View Controller" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor colorWithRed:0.2912 green:0.904 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(buttonClickPush:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}
- (id<UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (operation == UINavigationControllerOperationPush) {
        return [PresentAnimator new];
    }else{
        return nil;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissAnimator new];
}

- (void)buttonClickPresent:(UIButton *)sender
{
    ToViewController *modalViewController = [ToViewController new];
    modalViewController.transitioningDelegate = self;
    modalViewController.type = @"present";
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:modalViewController animated:YES completion:NULL];
}
- (void)buttonClickPush:(UIButton *)sender
{
    ToViewController *modalViewController = [ToViewController new];
    self.navigationController.delegate = self;
    modalViewController.type = @"push";
    [self.navigationController pushViewController:modalViewController animated:YES];
}
@end
