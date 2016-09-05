//
//  XTScrollLabelView.h
//  XTAnimations
//
//  Created by zjwang on 16/7/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XTScrollLabelView;

typedef NS_ENUM(NSInteger, ScrollDirectionType) {
    FromLeftType        = 0,
    FromRightType       = 1,
    
};

@protocol XTScrollLabelViewDelegate <NSObject>

@optional

- (void)drawMarqueeView:(XTScrollLabelView *)drawMarqueeView animationDidStopFinished:(BOOL)finished;

@end


@interface XTScrollLabelView : UIView

// 协议
@property (nonatomic, weak) id <XTScrollLabelViewDelegate> delegate;

// 速度
@property (nonatomic) CGFloat                               speed;

// 方向
@property (nonatomic) ScrollDirectionType                   marqueeDirection;

// 容器
- (void)addContentView:(UIView *)view;

// 开始
- (void)startAnimation;

// 停止
- (void)stopAnimation;

// 暂停
- (void)pauseAnimation;

// 恢复
- (void)resumeAnimation;
@end
