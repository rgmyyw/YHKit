# YHKit

[![CI Status](https://img.shields.io/travis/nilhy/YHKit.svg?style=flat)](https://travis-ci.org/nilhy/YHKit)
[![Version](https://img.shields.io/cocoapods/v/YHKit.svg?style=flat)](https://cocoapods.org/pods/YHKit)
[![License](https://img.shields.io/cocoapods/l/YHKit.svg?style=flat)](https://cocoapods.org/pods/YHKit)
[![Platform](https://img.shields.io/cocoapods/p/YHKit.svg?style=flat)](https://cocoapods.org/pods/YHKit)


## 简介

## 结构
* YHNavigationController
* YHViewController
    - YHNavBarViewController
        - YHViewController
            - YHTableViewCotnroler
                - YHRefreshTableViewControler
            - YHCollectionViewControler
                - YHRefreshCollectionViewControler
            - YHWebViewControler
            

#### YHNavigationController 

* 仅适用导航控制器的逻辑功能, 不适用系统导航条.
* 隐藏导航条
* 全局滑动返回和控制全局滑动返回的功能

```swift
// MARK:- gesture
extension YHNavigationController: UIGestureRecognizerDelegate {
    private func getSystemGestureOfBack() {
        let panGes = UIPanGestureRecognizer(target: self.interactivePopGestureRecognizer?.delegate, action: Selector(("handleNavigationTransition:")))
        view.addGestureRecognizer(panGes)
        panGes.delegate = self
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let vc = self.childViewControllers.last as? NJNavBarViewController {
            return (self.childViewControllers.count > 1 && !vc.nj_interactivePopDisabled)
        }else {
            return false
        }
    }
}
```

#### YHNavigationBar 

```swift

public let bottomSepLineView = UIView()
public let titleLabel = UILabel()
    
```

#### YHNavBarViewController 

* 继承自 UIViewController, 添加了一个自定义的导航条 View (YHNavigationBar)

```swift

yh_navigationBar.isHidden = !(parent != nil && parent!.isKind(of: NJNavigationController.classForCoder()))

```

* 处理 StatusBar


```swift
// MARK:- StatusBar
//        setNeedsStatusBarAppearanceUpdate()
extension YHNavBarViewController {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}
```

* 控制标题
```swift

yh_navigationBar.titleLabel.text = navigationItem.title != nil ? navigationItem.title : title
navigationItem.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)

override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let navigationItem = object as? UINavigationItem
        if keyPath! == "title" && (navigationItem != nil) && (navigationItem! == self.navigationItem) {
            nj_navigationBar.titleLabel.text = change?[NSKeyValueChangeKey.newKey] as? String
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
```


#### YHViewController

* 基本设置
```swift

view.backgroundColor = UIColor.groupTableViewBackground
automaticallyAdjustsScrollViewInsets = false
```
* 控制器释放的打印

#### YHTableViewController
* 拥有一个 UITableView, 添加在 self.view上
```swift

@IBOutlet var tableView: UITableView?

override func viewDidLoad() {
    super.viewDidLoad()
    if tableView == nil {
        addTableView()
    }
    setupTableView()
}

func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scrollView.scrollIndicatorInsets = scrollView.contentInset
    view.endEditing(true)
}

```

#### YHCollectionViewController

* 拥有一个 UICollectionView, 添加在 self.view上

#### YHWebViewController

* 添加一个 WKWebView 在 self.view上
* 实现 wkwebView 所有的基本配置
* 导航条上添加 ** 返回 ** ** 关闭 ** 按钮 实现基本的网页浏览功能
* 监听进度, 监听标题改变, 监听 contentSize 改变,

```swift
public var isNeedProgressLine: Bool = true
public var isAutoChangeTitle: Bool = true
public var webView: WKWebView? = nil
public var html: String? = nil
private lazy var closeBtn: UIButton = UIButton(type: UIButtonType.custom)
private lazy var backBtn: UIButton = UIButton(type: UIButtonType.custom)
private lazy var progressView: UIProgressView = UIProgressView()
public var gotoUrl: String? {
    didSet {
        gotoUrl = self.gotoUrl?.addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: "`#%^{}\"[]|\\<> ").inverted)
    }
}

```
#### YHRefreshTableViewController

* 让 TableView 拥有上拉加载, 下拉刷新的功能

#### YHRefreshCollectionViewController

* 让 CollectionView 拥有上拉加载, 下拉刷新的功能


## Requirements

`Swift5.0`


## Installation

YHKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'YHKit'
```

## Author

nilhy, coderhaiyang@gmail.com

## License

YHKit is available under the MIT license. See the LICENSE file for more info.
