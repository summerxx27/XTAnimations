# XTAnimations
About the collection of various forms of animation

### YY直播点赞效果
![](http://ww4.sinaimg.cn/large/e6a4355cgw1f5ttdqlqrvg208w0h2x6s.gif)
```objectivec
XTLoveHeartView *heart = [[XTLoveHeartView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
[self.view addSubview:heart];
CGPoint fountainSource = CGPointMake(self.view.frame.size.width - 80, self.view.bounds.size.height - 30 / 2.0 - 10);
heart.center = fountainSource;
[heart animateInView:self.view];
```
### 烟花演示效果
![](http://ww3.sinaimg.cn/large/e6a4355cgw1f5tll5lp8qg208w0gk7wk.gif)
```objectivec
self.caELayer                   = [CAEmitterLayer layer];
// 发射源
self.caELayer.emitterPosition   = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
// 发射源尺寸大小
self.caELayer.emitterSize       = CGSizeMake(50, 0);
// 发射源模式
self.caELayer.emitterMode       = kCAEmitterLayerOutline;
// 发射源的形状
self.caELayer.emitterShape      = kCAEmitterLayerLine;
// 渲染模式
self.caELayer.renderMode        = kCAEmitterLayerAdditive;
// 发射方向
self.caELayer.velocity          = 1;
// 随机产生粒子
self.caELayer.seed              = (arc4random() % 100) + 1;

// cell
CAEmitterCell *cell             = [CAEmitterCell emitterCell];
// 速率
cell.birthRate                  = 1.0;
// 发射的角度
cell.emissionRange              = 0.11 * M_PI;
// 速度
cell.velocity                   = 300;
// 范围
cell.velocityRange              = 150;
// Y轴 加速度分量
cell.yAcceleration              = 75;
// 声明周期
cell.lifetime                   = 2.04;
//是个CGImageRef的对象,既粒子要展现的图片
cell.contents                   = (id)
[[UIImage imageNamed:@"FFRing"] CGImage];
// 缩放比例
cell.scale                      = 0.2;
// 粒子的颜色
cell.color                      = [[UIColor colorWithRed:0.6
green:0.6
blue:0.6
alpha:1.0] CGColor];
// 一个粒子的颜色green 能改变的范围
cell.greenRange                 = 1.0;
// 一个粒子的颜色red 能改变的范围
cell.redRange                   = 1.0;
// 一个粒子的颜色blue 能改变的范围
cell.blueRange                  = 1.0;
// 子旋转角度范围
cell.spinRange                  = M_PI;

// 爆炸
CAEmitterCell *burst            = [CAEmitterCell emitterCell];
// 粒子产生系数
burst.birthRate                 = 1.0;
// 速度
burst.velocity                  = 0;
// 缩放比例
burst.scale                     = 2.5;
// shifting粒子red在生命周期内的改变速度
burst.redSpeed                  = -1.5;
// shifting粒子blue在生命周期内的改变速度
burst.blueSpeed                 = +1.5;
// shifting粒子green在生命周期内的改变速度
burst.greenSpeed                = +1.0;
//生命周期
burst.lifetime                  = 0.35;


// 火花 and finally, the sparks
CAEmitterCell *spark            = [CAEmitterCell emitterCell];
//粒子产生系数，默认为1.0
spark.birthRate                 = 400;
//速度
spark.velocity                  = 125;
// 360 deg//周围发射角度
spark.emissionRange             = 2 * M_PI;
// gravity//y方向上的加速度分量
spark.yAcceleration             = 75;
//粒子生命周期
spark.lifetime                  = 3;
//是个CGImageRef的对象,既粒子要展现的图片
spark.contents                  = (id)
[[UIImage imageNamed:@"FFTspark"] CGImage];
//缩放比例速度
spark.scaleSpeed                = -0.2;
//粒子green在生命周期内的改变速度
spark.greenSpeed                = -0.1;
//粒子red在生命周期内的改变速度
spark.redSpeed                  = 0.4;
//粒子blue在生命周期内的改变速度
spark.blueSpeed                 = -0.1;
//粒子透明度在生命周期内的改变速度
spark.alphaSpeed                = -0.25;
//子旋转角度
spark.spin                      = 2* M_PI;
//子旋转角度范围
spark.spinRange                 = 2* M_PI;


self.caELayer.emitterCells = [NSArray arrayWithObject:cell];
cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
burst.emitterCells = [NSArray arrayWithObject:spark];
[self.view.layer addSublayer:self.caELayer];
```
### SNOW
![](http://ww4.sinaimg.cn/large/e6a4355cgw1f61moqud49g208w0gp4qq.gif)
```objectivec
// 创建粒子Layer
CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];

// 粒子发射位置
snowEmitter.emitterPosition = CGPointMake(120,0);

// 发射源的尺寸大小
snowEmitter.emitterSize     = self.view.bounds.size;

// 发射模式
snowEmitter.emitterMode     = kCAEmitterLayerSurface;

// 发射源的形状
snowEmitter.emitterShape    = kCAEmitterLayerLine;

// 创建雪花类型的粒子
CAEmitterCell *snowflake    = [CAEmitterCell emitterCell];

// 粒子的名字
snowflake.name = @"snow";

// 粒子参数的速度乘数因子
snowflake.birthRate = 20.0;
snowflake.lifetime  = 120.0;

// 粒子速度
snowflake.velocity  = 10.0;

// 粒子的速度范围
snowflake.velocityRange = 10;

// 粒子y方向的加速度分量
snowflake.yAcceleration = 2;

// 周围发射角度
snowflake.emissionRange = 0.5 * M_PI;

// 子旋转角度范围
snowflake.spinRange = 0.25 * M_PI;
snowflake.contents  = (id)[[UIImage imageNamed:@"snow"] CGImage];

// 设置雪花形状的粒子的颜色
snowflake.color      = [[UIColor whiteColor] CGColor];
snowflake.redRange   = 1.5f;
snowflake.greenRange = 2.2f;
snowflake.blueRange  = 2.2f;

snowflake.scaleRange = 0.6f;
snowflake.scale      = 0.7f;

snowEmitter.shadowOpacity = 1.0;
snowEmitter.shadowRadius  = 0.0;
snowEmitter.shadowOffset  = CGSizeMake(0.0, 0.0);

// 粒子边缘的颜色
snowEmitter.shadowColor  = [[UIColor whiteColor] CGColor];

// 添加粒子
snowEmitter.emitterCells = @[snowflake];

// 将粒子Layer添加进图层中
[self.view.layer addSublayer:snowEmitter];

// 形成遮罩
UIImage *image      = [UIImage imageNamed:@"alpha"];
_layer              = [CALayer layer];
_layer.frame        = (CGRect){CGPointZero, self.view.bounds.size};
_layer.contents     = (__bridge id)(image.CGImage);
_layer.position     = self.view.center;
snowEmitter.mask    = _layer;
```
### 跑马灯
![](http://ww4.sinaimg.cn/large/e6a4355cgw1f61mq3x60gg208w0gnkjl.gif)
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
@"勤劳",
@"年轻",
@"刻苦",
@"开玩笑",
@"都是我编的, 前面的别跑"];
return array[arc4random() % array.count];
}

```

