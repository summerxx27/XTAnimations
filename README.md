# XTAnimations
About the collection of various forms of animation

<table border="1">
<tr>
<td><img src="http://ww4.sinaimg.cn/large/e6a4355cgw1f5ttdqlqrvg208w0h2x6s.gif" width="200" height="300"></td>
<td><img src="http://ww3.sinaimg.cn/large/e6a4355cgw1f5tll5lp8qg208w0gk7wk.gif" width="200" height="300"></td>
<td><img src="http://ww4.sinaimg.cn/large/e6a4355cgw1f61moqud49g208w0gp4qq.gif" width="200" height="300"></td>
<td><img src="http://ww4.sinaimg.cn/large/e6a4355cgw1f61mq3x60gg208w0gnkjl.gif" width="200" height="300"></td>
</tr>
</table>

<table border="1">
<tr>
<td><img src="http://ww4.sinaimg.cn/large/e6a4355cgw1f6ujncz5dsj208p0fyab1.jpg" width="200" height="300"></td>
<td><img src="http://ww1.sinaimg.cn/large/e6a4355cgw1f6ujnyhu1hj208l0fumzb.jpg" width="200" height="300"></td>
</tr>
</table>

### YY直播点赞效果模仿

```objectivec
XTLoveHeartView *heart = [[XTLoveHeartView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
[self.view addSubview:heart];
CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
heart.center = fountainSource;
[heart animateInView:self.view];
```
#### 跑马灯

```objectivec
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
    @"年轻",
    @"刻苦",
    @"开玩笑",
    @"都是我编的, 前面的别跑"];
    return array[arc4random() % array.count];
}

```

### POP实践

```objectivec
- (void)click:(UIButton *)btn
{
    XTPopingView *view = [[XTPopingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view.fly_h = 350;
    view.fly_w = 250;
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.fly_w, view.fly_h)];
    headerImage.image = [UIImage imageNamed:@"chenyao.jpg"];

    [self.view addSubview:view];
    [view.flyView addSubview:headerImage];
    [view startFly:FlyTypeUToD];
}
```
### 点赞加自定义图片样式
>在原有的基础上进行的修改
如图六
