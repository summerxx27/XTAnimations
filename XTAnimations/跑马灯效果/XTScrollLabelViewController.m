//
//  XTScrollLabelViewController.m
//  XTAnimations
//
//  Created by zjwang on 16/7/21.
//  Copyright © 2016年 夏天然后. All rights reserved.
//

#import "XTScrollLabelViewController.h"
#import "XTScrollLabelView.h"
#import "NSString+XTAdd.h"
@interface XTScrollLabelViewController ()<XTScrollLabelViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end

@implementation XTScrollLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    XTScrollLabelView *drawMarqueeView0   = [[XTScrollLabelView alloc] initWithFrame:CGRectMake(0, 104, self.view.frame.size.width, 20)];
    XTScrollLabelView *drawMarqueeView1  = [[XTScrollLabelView alloc] initWithFrame:CGRectMake(0, 124, self.view.frame.size.width, 20)];
    XTScrollLabelView *drawMarqueeView2  = [[XTScrollLabelView alloc] initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, 20)];
    XTScrollLabelView *drawMarqueeView3  = [[XTScrollLabelView alloc] initWithFrame:CGRectMake(0, 164, self.view.frame.size.width, 20)];

    drawMarqueeView0.delegate          = self;
    drawMarqueeView1.delegate         = self;
    drawMarqueeView2.delegate         = self;
    drawMarqueeView3.delegate         = self;
    
    //
    drawMarqueeView0.marqueeDirection  = FromLeftType;
    drawMarqueeView1.marqueeDirection  = FromLeftType;
    drawMarqueeView2.marqueeDirection  = FromLeftType;
    drawMarqueeView3.marqueeDirection  = FromLeftType;

    // add
    [self.view addSubview:drawMarqueeView0];
    [self.view addSubview:drawMarqueeView1];
    [self.view addSubview:drawMarqueeView2];
    [self.view addSubview:drawMarqueeView3];

    // text
    [drawMarqueeView0 addContentView:[self createLabelWithText:@"夏天是个很好的季节, 而夏天然后是简书的推荐作者, 喜欢分享!"
                                                    textColor:[self randomColor]]];
    [drawMarqueeView1 addContentView:[self createLabelWithText:@"夏天然后是简书的推荐作者"
                                                    textColor:[self randomColor]]];
    [drawMarqueeView2 addContentView:[self createLabelWithText:@"夏天是个iOS开发者"
                                                    textColor:[self randomColor]]];
    [drawMarqueeView3 addContentView:[self createLabelWithText:@"喜欢分享!"
                                                    textColor:[self randomColor]]];
    
    // start
    [drawMarqueeView0 startAnimation];
    [drawMarqueeView1 startAnimation];
    [drawMarqueeView2 startAnimation];
    [drawMarqueeView3 startAnimation];

}
#pragma mark -
- (UILabel *)createLabelWithText:(NSString *)text textColor:(UIColor *)textColor {
    
    NSString *string = [NSString stringWithFormat:@" %@ ", text];
    CGFloat width = [string widthWithStringAttribute:@{NSFontAttributeName : [UIFont systemFontOfSize:14.f]}];
    UILabel  *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    label.font       = [UIFont systemFontOfSize:14.f];
    label.text       = string;
    label.textColor  = textColor;
    return label;
}
#pragma mark -
- (UIColor *)randomColor {
    
    return [UIColor colorWithRed:[self randomValue] green:[self randomValue] blue:[self randomValue] alpha:1];
}
#pragma mark -
- (CGFloat)randomValue {
    
    return arc4random() % 256 / 255.f;
}
#pragma mark -
- (void)drawMarqueeView:(XTScrollLabelView *)drawMarqueeView animationDidStopFinished:(BOOL)finished
{
    [drawMarqueeView stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [drawMarqueeView addContentView:[self createLabelWithText:[self randomString]
                                                        textColor:[self randomColor]]];
        [drawMarqueeView startAnimation];
    });
}
#pragma mark -
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
