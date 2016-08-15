//
//  Copyright (c) 2016 夏天然后. All rights reserved.
//

#import "PresentAnimator.h"
#import <POP/POP.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation PresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.frame = CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    [transitionContext.containerView addSubview:toView];

    POPSpringAnimation *positionAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnim.toValue = @(transitionContext.containerView.center.y);
    positionAnim.springBounciness = 10;
    [positionAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.springBounciness = 20;
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    [toView.layer pop_addAnimation:positionAnim forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnim forKey:@"scaleAnimation"];
    
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

@end
