//
//  XTTransAnimate.m
//  XTAnimations
//
//  Created by summerxx on 2016/12/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTTransAnimate.h"

@implementation XTTransAnimate
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *desController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *srcController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect shadowStartFrame, shadowEndFrame;
    
    
    CGRect srcViewRectTo;
    CGRect desViewRectTo;
    CGRect srcViewRectFrom;
    CGRect desViewRectFrom;
    
    UIView *maskView = nil;
    
    CGFloat maskAlphaend = 0.0;
    UIImageView *shadowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topic_bar_bg@2x"]];
    
    if (_theType == animateTypePush) {
        [[transitionContext containerView] addSubview:desController.view];
        
        srcViewRectTo = CGRectMake(-[UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        desViewRectTo = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        srcViewRectFrom = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        desViewRectFrom = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    else if (_theType == animateTypePop) {
        
        
        
        
        [[transitionContext containerView] insertSubview:desController.view belowSubview:srcController.view];
        
        
        srcViewRectTo = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        desViewRectTo = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        srcViewRectFrom = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        desViewRectFrom = CGRectMake(-[UIScreen mainScreen].bounds.size.width/2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        
        maskView.frame = desViewRectFrom;
        maskView.alpha = 0.3;
        [[transitionContext containerView] insertSubview:maskView belowSubview:srcController.view];
        
        shadowStartFrame  = CGRectMake(srcViewRectFrom.origin.x - 8, srcViewRectFrom.origin.y, 8, srcViewRectFrom.size.height);
        shadowEndFrame    = CGRectMake(srcViewRectTo.origin.x - 8, srcViewRectTo.origin.y, 8, srcViewRectTo.size.height);
        [[transitionContext containerView] insertSubview:shadowImageView aboveSubview:maskView];
        
    }
    
    desController.view.frame   = desViewRectFrom;
    srcController.view.frame = srcViewRectFrom;
    shadowImageView.frame         = shadowStartFrame;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         desController.view.frame   = desViewRectTo;
                         srcController.view.frame = srcViewRectTo;
                         shadowImageView.frame = shadowEndFrame;
                         maskView.frame = desViewRectTo;
                         maskView.alpha = maskAlphaend;
                         
                     }
                     completion:^(BOOL finished) {
                         [shadowImageView removeFromSuperview];
                         [maskView removeFromSuperview];
                         //srcController.view.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}
@end
