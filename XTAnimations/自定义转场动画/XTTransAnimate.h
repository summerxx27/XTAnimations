//
//  XTTransAnimate.h
//  XTAnimations
//
//  Created by summerxx on 2016/12/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    animateTypePush,
    animateTypePop
}animateType;
@interface XTTransAnimate : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) animateType theType;

@end
