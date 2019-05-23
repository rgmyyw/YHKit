//
//  YHFPSLabel.swift
//  YHKit
//
//  Created by nilhy on 2018/9/22.
//

import UIKit
import SnapKit

public class YHDebugTool: NSObject
{
    public static let defaultTool = YHDebugTool()
    private let window = UIView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 50))
    private lazy var fpsLabel: UILabel = {
        let fpsLabel = UILabel()
        fpsLabel.textAlignment = .center
        fpsLabel.textColor = UIColor.green
        fpsLabel.font = UIFont.systemFont(ofSize: 12)
        return fpsLabel
    }()
    private lazy var timer: CADisplayLink  = {
        let displayLink = CADisplayLink(target: self, selector: #selector(fpsTick(displayLink:)))
        return displayLink
    }()
    private var timeTickCount: Double = 0
    private var lastTimestamp: Double = 0
    private override init()
    {
        super.init()
        setupUIOnce()
    }
    public func show()
    {
        window.isHidden = false
        UIApplication.shared.keyWindow?.addSubview(window)
        timer.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    public func hide()
    {
        window.isHidden = true
        timer.remove(from: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
}

extension YHDebugTool
{
    private func setupUIOnce()
    {
        window.isHidden = false
        window.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        addPanGes()
        addFPSLabel()
        layoutSubViews()
    }
    private func addPanGes()
    {
        let panGes = UIPanGestureRecognizer(target: self, action: #selector(windowPanGes(PanGes:)))
        window.addGestureRecognizer(panGes)
    }

    private func layoutSubViews()
    {
        let subViews = window.subviews
        if subViews.count == 0
        {
            return
        }
        let width = window.frame.width / CGFloat(subViews.count)
        let height = window.frame.height
        for (index, view) in subViews.enumerated()
        {
            let frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: height)
            view.frame = frame
        }
    }
}

extension YHDebugTool: UIGestureRecognizerDelegate
{
    @objc func windowPanGes(PanGes: UIPanGestureRecognizer) -> Void
    {
        let transtion = PanGes.translation(in: PanGes.view!)
        var center = PanGes.view!.center
        center.y += transtion.y
        PanGes.view?.center = center
        PanGes.setTranslation(CGPoint(x: 0, y: 0), in: PanGes.view)
    }
}

// MARK:- FPS
extension YHDebugTool
{
    private func addFPSLabel()
    {
        let view = UIView()
        window.addSubview(view)
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        view.addSubview(fpsLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.text = "FPS"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
        }
        fpsLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalToSuperview()
        }
    }
    @objc func fpsTick(displayLink: CADisplayLink)
    {
        self.timeTickCount += 1
        let timestamp = displayLink.timestamp
        
        if self.lastTimestamp == 0 {
            self.lastTimestamp = timestamp
            return
        }
        
        let delta = timestamp - self.lastTimestamp
        if delta < 1 {
            return
        }
        
        let fps = self.timeTickCount / delta
        
        self.lastTimestamp = timestamp
        self.timeTickCount = 0
        
        fpsLabel.text = "\(Int(ceilf(Float(fps))))"
    }
}
