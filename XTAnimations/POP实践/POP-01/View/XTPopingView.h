//
//  XTViewTips1.h
//  POP_Tips
//
//  Created by zjwang on 16/7/29.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>

typedef NS_ENUM(NSInteger, FlyType) {
    FlyTypeUToD     = 0,
    FlyTypeDToD     = 1,
};
@interface XTPopingView : UIView
@property (nonatomic, strong) UIView *flyView;
@property (nonatomic, assign) CGFloat fly_w;
@property (nonatomic, assign) CGFloat fly_h;


- (void)startFly:(FlyType)type;

@end
