//
//  GeometricLoader.swift
//  GeometricLoaders
//
//  Created by Pablo Garcia on 16/10/2017.
//  Copyright © 2017 Pablo Garcia. All rights reserved.
//

import UIKit

public class GeometricLoader: UIView {
    internal var loaderView = UIView()
    internal var loaderSuperview: UIView?
    internal var isAnimating = false

    public static func createGeometricLoader() -> Self {
        let loader = self.init()
        loader.setupView()

        return loader
    }

    internal func configureLoader() {
        preconditionFailure("This method has to be called from GeometricLoader subclass")
    }

    open func startAnimation() {
        configureLoader()
        isHidden = false
        if superview == nil {
            loaderSuperview?.addSubview(self)
        }
    }

    open func stopAnimation() {
        isHidden = false
        isAnimating = false
        removeFromSuperview()
        layer.removeAllAnimations()
    }

    internal func setupView() {
        guard let window = UIApplication.shared.delegate?.window else { return }
        guard let mainWindow = window else { return }

        frame = mainWindow.frame
        center = CGPoint(x: mainWindow.bounds.midX, y: mainWindow.bounds.midY)

        mainWindow.addSubview(self)

        loaderSuperview = mainWindow
        loaderView.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width / 2, height: frame.width / 2)
        loaderView.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        loaderView.backgroundColor = UIColor.clear
        isHidden = true
        addSubview(loaderView)
    }
}
