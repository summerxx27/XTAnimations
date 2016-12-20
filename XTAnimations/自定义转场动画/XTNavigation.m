//
//  XTNavigation.m
//  XTAnimations
//
//  Created by summerxx on 2016/12/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTNavigation.h"
#import "XTTransAnimate.h"
@implementation XTNavigation


- (instancetype)init{
    
    if (self = [super init]) {
        _pushAnimation = [[XTTransAnimate alloc] init];
        ((XTTransAnimate *)_pushAnimation).theType = animateTypePush;
        _popAnimation = [[XTTransAnimate alloc] init];
        ((XTTransAnimate *)_popAnimation).theType = animateTypePop;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimation;
    }
    else if (operation == UINavigationControllerOperationPop) {
        return self.popAnimation;
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}


+(XTNavigation *)getNavigationPerformerInstance {
    static dispatch_once_t once;
    static XTNavigation *navigationPerformerInstance;
    dispatch_once(&once, ^{
        navigationPerformerInstance = [[XTNavigation alloc] init];
    });
    return navigationPerformerInstance;
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    UIView *view = self.referenceNaviController.view;
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _locationS = [pan translationInView:view];
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [pan translationInView:view];
        
        if (translation.x - _locationS.x > 0 && self.referenceNaviController.viewControllers.count > 1) {
            if (!_isInMoveState) {
                _isInMoveState = YES;
                self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
                [self.referenceNaviController popViewControllerAnimated:YES];
            }
        }
        CGFloat progress = (translation.x - _locationS.x) / [UIScreen mainScreen].bounds.size.width;
        [self.interactionController updateInteractiveTransition:progress];
    }
    else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [pan translationInView:view];
        if(translation.x - _locationS.x > 20) {
            [self.interactionController finishInteractiveTransition];
        }
        else {
            [self.interactionController cancelInteractiveTransition];
        }
        _isInMoveState = NO;
        _locationS = CGPointZero;
        self.interactionController = nil;
    }
}

-(void)setupPanGesture: (UINavigationController *)referenceNaviController {
    self.referenceNaviController = referenceNaviController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.referenceNaviController.view addGestureRecognizer:panGesture];
}
@end
