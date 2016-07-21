//
//  XTScrollLabelViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTScrollLabelViewController.h"
#import "XTScrollLabelView.h"
#import "NSString+Width.h"
@interface XTScrollLabelViewController ()<XTScrollLabelViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation XTScrollLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    XTScrollLabelView *drawMarqueeView  = [[XTScrollLabelView alloc] initWithFrame:CGRectMake(0, 0, 250.f, 20)];
    drawMarqueeView.delegate          = self;
    drawMarqueeView.marqueeDirection  = FromLeftType;
    drawMarqueeView.center            = self.view.center;
    [self.view addSubview:drawMarqueeView];
    [drawMarqueeView addContentView:[self createLabelWithText:@"夏天是个很好的季节, 而夏天然后是简书的推荐作者, 喜欢分享!"
                                                    textColor:[self randomColor]]];
    [drawMarqueeView startAnimation];
    
}

- (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor {
    
    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat width = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.font       = [UIFont systemFontOfSize:14.f];
    label.text       = string;
    label.textColor  = textColor;
    
    return label;
}
- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}
- (CGFloat)randomValue {
    
    return arc4random() % 256 / 255.f;
}
- (void)drawMarqueeView:(XTScrollLabelView *)drawMarqueeView animationDidStopFinished:(BOOL)finished
{
    [drawMarqueeView stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [drawMarqueeView addContentView:[self createLabelWithText:[self randomString]
                                                        textColor:[self randomColor]]];
        [drawMarqueeView startAnimation];
    });
}
- (NSString *)randomString {
    
    NSArray *array = @[@"人帅",
                       @"勤劳",
                       @"年轻",
                       @"刻苦",
                       @"开玩笑",
                       @"都是我编的, 前面的别跑"];
    return array[arc4random() % array.count];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
