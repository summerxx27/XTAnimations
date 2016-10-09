//
//  XTViewTips1.m
//  POP_Tips
//
//  Created by zjwang on 16/7/29.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTPopingView.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation XTPopingView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:self.flyView];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}
- (UIView *)flyView
{
    if (!_flyView) {
        _flyView = [[UIView alloc] init];
    }
    return _flyView;
}

- (void)startFly:(FlyType)type
{
    switch (type) {
        case FlyTypeUToD:
        {
            _flyView.frame = CGRectMake(SCREEN_WIDTH / 2 - self.fly_w / 2, -self.fly_h, self.fly_w, self.fly_h);
        }
            break;
        case FlyTypeDToD:
        {
            _flyView.frame = CGRectMake(SCREEN_WIDTH / 2 - self.fly_w / 2, SCREEN_HEIGHT + self.fly_h, self.fly_w, self.fly_h);
        }
        default:
            break;
    }
    _flyView.backgroundColor = [UIColor purpleColor];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:self.center];
    // 速度
    anim.springSpeed = 5;
    // 弹力--晃动的幅度 (springSpeed速度)
    anim.springBounciness = 10.0f;
    [_flyView pop_addAnimation:anim forKey:@"animationShow"];
}
- (void)tapClickAction
{
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, SCREEN_HEIGHT + self.fly_h)];
    [_flyView pop_addAnimation:anim forKey:@"animationRemove"];
    anim.springSpeed = 5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}
@end
