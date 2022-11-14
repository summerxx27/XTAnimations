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
<td><img src="https://tva1.sinaimg.cn/large/007S8ZIlly1ggsx5mk0csg30gq0xc1l0.gif" width="180" height="325"></td>
</tr>
</table>

### 这里写一下用的写的部分Swift

前言: 最新更新的`Swift`版本跑马灯, 属于玩票性质的演示`Demo`, 随着`Swift ABI`的稳定, 我打算重新系统学习一下`Swift`, 所以把之前可以翻译的Objective-C版本的项目, 进行了翻译. 一下简答介绍下用到的一些小的Tips



#### 1 枚举

#### 1.1 定义以及简单使用

```swift

/// 定义了一个枚举
enum MovingDirectionType {
    case left
    case right
    case bottom
    case top
}
/// switch当中的使用
switch moveType {
        case .left:
            fromPoint = pointRightCenter
            toPoint = pointLeftCenter
        case .right:
            fromPoint = pointLeftCenter
            toPoint = pointRightCenter
        case .bottom:
            fromPoint = pointBottomCenter
            toPoint = pointUpCenter
        case .top:
            fromPoint = pointUpCenter
            toPoint = pointBottomCenter
        }

```

#### 1.2 枚举的遍历

令枚举遵循 `CaseIterable` 协议。Swift 会生成一个 `allCases` 属性，用于表示一个包含枚举所有成员的集合。 简单的示例代码

```Swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count

for beverage in Beverage.allCases {
    print(beverage)
}
```

### 1.3 枚举可以关联值

```Swift
/// 定义一个枚举
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
/// 赋值
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
/// 打印
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// 打印“QR code: ABCDEFGHIJKLMNOP.”  以上就是我常用的枚举的一些小的Tips
```

### 2. 协议

下面这样写是一个必须要实现的协议方法, 那么可选应该怎么实现呢

```Swift
protocol XTMovingViewProtocol {
    func drawMarqueeView(drawMarqueeView: XTMovingView, animationDidStopFinished: Bool) -> Void
}
/// 可选可以这样实现
extension XTMovingViewProtocol {
    
}
```

### 3. 一些属性的定义, 要给初始值, 安全考虑

```Swift
/// 速度
    var speed: Float = 1.0
    /// 宽
    var width: Float = 0.0
    /// 高
    var height: Float = 0.0
    /// 动画视图宽
    var animationViewWidth: Float = 0.0
    /// 动画视图高
    var animationViewHeight: Float = 0.0
    /// 是否停止
    var stop: Bool = true
    /// 方向
    var moveType: MovingDirectionType = .left
    /// 内容
    var contentView = UIView()
    /// 动画视图
    var animationView = UIView()
    /// 协议
    var delegate : XTMovingViewProtocol?
```

### 4. 自定义View 要实现这个方法

```Swift
required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
```

### 5. 简单动画

跟ObjC基本没区别

```Swift
animationView.center = fromPoint
        let movePath = UIBezierPath.init()
        movePath.move(to: fromPoint)
        movePath.addLine(to: toPoint)
        
        let moveAnimation = CAKeyframeAnimation.init(keyPath: "position")
        moveAnimation.path = movePath.cgPath
        moveAnimation.isRemovedOnCompletion = true
        moveAnimation.duration = CFTimeInterval(animationViewWidth / 30 * (1 / speed))
        moveAnimation.delegate = self
        animationView.layer.add(moveAnimation, forKey: "animationViewPosition")
```

### 6. String+Cal.swift文件为字符串扩展了一个方法

```Swift
extension NSString {
    func calculateWidthWithAttributeText(dic: Dictionary<NSAttributedString.Key, Any>) -> Double {
        let rect = self.boundingRect(with: CGSize.init(width: 1000000000, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin.union(NSStringDrawingOptions.usesFontLeading).union(NSStringDrawingOptions.usesDeviceMetrics), attributes: dic, context: nil)
        return Double(ceil(rect.size.width))
    }
}
```

 以上就是这次把ObjC翻译成Swift的大致情况~ !