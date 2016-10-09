//
//  XTLikePictureView.h
//  XTAnimations
//
//  Created by zjwang on 16/8/15.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTThumbUpAnimation : UIView
@property (nonatomic, strong) UIImageView *imageView;

- (void)animatePictureInView:(UIView *)view Image:(UIImage *)image;

@end
