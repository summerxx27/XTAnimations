//
//  XTNavigation.h
//  XTAnimations
//
//  Created by summerxx on 2016/12/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XTNavigation : NSObject<UINavigationControllerDelegate>
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> pushAnimation;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> popAnimation;
@property (nonatomic, weak) UINavigationController *referenceNaviController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@property (nonatomic, assign) CGPoint locationS;
+(XTNavigation *)getNavigationPerformerInstance;
-(void)setupPanGesture: (UINavigationController *)referenceNaviController;
@property (nonatomic, assign) BOOL isInMoveState;
@end
