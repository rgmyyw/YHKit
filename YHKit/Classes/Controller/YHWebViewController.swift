
//
//  YHWebViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit
import WebKit

public protocol YHWebViewControllerDelegate {
    func webViewBackBtnClick(_ webView: WKWebView, _ controller: YHWebViewController, _ btn: UIButton?) -> Void
    func webViewCloseBtnClick(_ webView: WKWebView, _ controller: YHWebViewController, _ btn: UIButton?) -> Void
    func webViewScrollViewContentSize(_ webView: WKWebView, _ controller: YHWebViewController, _ scrollView: UIScrollView, _ contentSize: CGSize) -> Void
}


open class YHWebViewController: YHViewController {
    
    public var isNeedProgressLine: Bool = true
    public var isAutoChangeTitle: Bool = true
    public var webView: WKWebView!
    public var html: String? = nil
    public lazy var backBtn: UIButton = UIButton(type: UIButtonType.custom)
    private lazy var closeBtn: UIButton = UIButton(type: UIButtonType.custom)
    private lazy var progressView: UIProgressView = UIProgressView()
    public var gotoUrl: String? {
        didSet {
            gotoUrl = self.gotoUrl?.yh_urlEncoding()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        yh_interactivePopDisabled = true
        yh_isBackActionBtnHidden = true
        addWkWebView()
        setUpWkWebView()
        addObservers()
        addActions()
        addprogressView()
        if let urlStr = gotoUrl {
            if let url = URL(string: urlStr) {
                let urlRequestM = NSMutableURLRequest(url: url)
                webView?.load(urlRequestM.copy() as! URLRequest)
            }
        }else if let htmlStr = html {
            webView?.loadHTMLString(htmlStr, baseURL: nil)
        }
    }
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubview(toFront: progressView)
    }
    deinit {
        if self.isViewLoaded {
            webView?.removeObserver(self, forKeyPath: "estimatedProgress")
            webView?.removeObserver(self, forKeyPath: "title")
            webView?.scrollView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
}

// MARK:- setting
extension YHWebViewController {
    private func addWkWebView() -> Void {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView!)
    }
    private func setUpWkWebView() -> Void {
        let preferences = WKPreferences()
        
        //The minimum font size in points default is 0;
        preferences.minimumFontSize = 0;
        //是否支持JavaScript
        preferences.javaScriptEnabled = true;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        webView?.configuration.preferences = preferences
        
        webView?.configuration.userContentController = WKUserContentController()
        
        // 检测各种特殊的字符串：比如电话、网站
        if #available(iOS 10.0, *) {
            webView?.configuration.dataDetectorTypes = .all
        } else {
            // Fallback on earlier versions
        }
        // 播放视频
        webView?.configuration.allowsInlineMediaPlayback = true;
        
        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        webView?.isOpaque = false
        
        webView?.backgroundColor = UIColor.clear
        
        webView?.allowsBackForwardNavigationGestures = true
        
        if #available(iOS 9.0, *) {
            webView?.allowsLinkPreview = true
        } else {
            // Fallback on earlier versions
        }
        
        webView?.uiDelegate = self;
        
        webView?.navigationDelegate = self;
        
        if #available(iOS 11, *) {
            webView?.scrollView.contentInsetAdjustmentBehavior = .never
        }
        if parent != nil && parent!.isKind(of: UINavigationController.self) {
            var contentInset = webView!.scrollView.contentInset
            contentInset.top += yh_navigationBar.frame.size.height
            webView?.scrollView.contentInset = contentInset
            webView?.scrollView.scrollIndicatorInsets = contentInset
        }
    }
    private func addObservers() {
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
        webView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
}
// MARK:- Observers
extension YHWebViewController {
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        let wkWebView = object as? WKWebView
        let scrollView = object as? UIView
        
        if ((wkWebView != nil) && (wkWebView! == self.webView)) && (keyPath! == "estimatedProgress" || keyPath! == "title") {
            if keyPath! == "estimatedProgress" {
                self.progressView.isHidden = !self.isNeedProgressLine
                if !self.isNeedProgressLine {
                    return
                }
                self.progressView.progress = Float(webView!.estimatedProgress);
                // 加载完成
                if self.webView!.estimatedProgress  >= 1.0  {
                    UIView.animate(withDuration: 0.25, animations: {
                        self.progressView.alpha = 0
                        self.progressView.progress = 0
                    })
                }else{
                    self.progressView.alpha = 1.0;
                }
            }else if keyPath! == "title" && self.isAutoChangeTitle {
                yh_navigationBar.titleLabel.text = change?[NSKeyValueChangeKey.newKey] as? String
            }
        } else if (scrollView != nil) && (scrollView! == self.webView?.scrollView) && keyPath! == "contentSize" {
            webViewScrollViewContentSize(self.webView!, self, self.webView!.scrollView, self.webView!.scrollView.contentSize)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}


// MARK:- WKNavigationDelegate-导航监听
extension YHWebViewController: WKNavigationDelegate {
    // 1, 在发送请求之前，决定是否跳转
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    // 3, 6, 加载 HTTPS 的链接，需要权限认证时调用  \  如果 HTTPS 是用的证书在信任列表中这不要此代理方法
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        if let trust = challenge.protectionSpace.serverTrust {
            let credential = URLCredential(trust: trust)
            completionHandler(.useCredential, credential)
        }else {
            completionHandler(.performDefaultHandling, nil)
        }
//        self.webView?.evaluateJavaScript("document.getElementById('html5player-video').src") { (el, error) in
//            print("3-6-3-6-3-6-3-6")
//            print(el)
//            print(error)
//        }
    }
    // 4, 在收到响应后，决定是否跳转, 在收到响应后，决定是否跳转和发送请求之前那个允许配套使用
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    // 1-2, 接收到服务器跳转请求之后调用
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 8, WKNavigation导航错误
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    //当 WKWebView 总体内存占用过大，页面即将白屏的时候，系统会调用回调函数
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}
// MARK:- WKNavigationDelegate-网页监听
extension YHWebViewController {
    // 2, 页面开始加载时调用
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 5,内容开始返回时调用
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 7页面加载完成之后调用
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // 9页面加载失败时调用
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
}

// MARK:- WKUIDelegate
extension YHWebViewController: WKUIDelegate {
    
}

// MARK:- btns
extension YHWebViewController {
    private func addActions() {
        
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(UIColor.black, for: .normal)
        closeBtn.setTitle("关闭", for: UIControlState.normal)
        closeBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        closeBtn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
        closeBtn.isHidden = true
        backBtn.sizeToFit()
        closeBtn.sizeToFit()
        
        yh_navigationBar.yh_leftBarButtonItems = [backBtn,closeBtn]
        
        backBtn.addTarget(self, action: #selector(btn_back(_:)), for: UIControlEvents.touchUpInside)
        closeBtn.addTarget(self, action: #selector(btn_close(_:)), for: UIControlEvents.touchUpInside)
    }
    @objc private func btn_back(_ btn: UIButton) -> Void {
        webViewBackBtnClick(webView!, self, btn)
    }
    @objc private func btn_close(_ btn: UIButton) -> Void {
        webViewCloseBtnClick(webView!, self, btn)
    }
}

// MARK:- progressView
extension YHWebViewController {
    private func addprogressView() {
        view.addSubview(self.progressView)
        progressView.frame = CGRect(x: 0, y: yh_navigationBar.frame.size.height, width: UIScreen.main.bounds.size.width, height: 1)
        progressView.tintColor = UIColor.green
    }
}

// MARK:- YHWebViewControllerDelegate
extension YHWebViewController: YHWebViewControllerDelegate {
    public func webViewScrollViewContentSize(_ webView: WKWebView, _ controller: YHWebViewController, _ scrollView: UIScrollView, _ contentSize: CGSize) {
//        print(webView, controller, scrollView, contentSize)
    }
    public func webViewBackBtnClick(_ webView: WKWebView, _ controller: YHWebViewController, _ btn: UIButton?) {
        if webView.canGoBack {
            webView.goBack()
            closeBtn.isHidden = false
        }else {
            webViewCloseBtnClick(webView, self, nil)
        }
    }
    // 判断两种情况: push 和 present
    public func webViewCloseBtnClick(_ webView: WKWebView, _ controller: YHWebViewController, _ btn: UIButton?) {
        if (navigationController?.presentedViewController != nil || navigationController?.presentingViewController != nil) && navigationController?.childViewControllers.count == 1 {
            dismiss(animated: true, completion: nil)
        }else if let navVc = navigationController {
            if navVc.childViewControllers.count > 1 {
                navVc.popViewController(animated: true)
            }
        }else if (presentationController != nil || presentedViewController != nil) {
            dismiss(animated: true, completion: nil)
        }
    }
}


