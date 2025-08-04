//
//  AlertViewModel.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.

import Foundation
import UIKit
protocol AlertViewModel {
    
    func show(animated: Bool)
    func dismiss(animated: Bool)
    var backgroundView: UIView {get set}
    var containerView: UIView {get set}
}

extension AlertViewModel where Self: UIView {
    
    func show(animated: Bool) {
        self.backgroundView.alpha = 0
         if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let subviewsList = topController.view.subviews
            for view in subviewsList where view is AlertView {
                view.removeFromSuperview()
                break
            }
            topController.view.addSubview(self)
        }
   
       /* if var topController = topWindow().rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let subviewsList = topController.view.subviews
            for view in subviewsList where view is AlertView {
                view.removeFromSuperview()
                break
            }
            topController.view.addSubview(self)
        } */
        
        if animated {
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.25, animations: {
                self.backgroundView.alpha = 1.0
                self.containerView.transform = .identity
            }, completion: { (_) in
                self.backgroundView.alpha = 1.0

            })
        }
    }
    
    func dismiss(animated: Bool) {
        if animated {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = .identity
            UIView.animate(withDuration: 0.11, animations: {
                self.backgroundView.alpha = 0.0
                self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { (_) in
                self.backgroundView.alpha = 0.0
                self.removeFromSuperview()
            })
        } else {
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        }
    }
    
    func topWindow() -> UIWindow {
        var keyboardWindow: UIWindow?
        for testWindow: UIWindow in UIApplication.shared.windows {
            let topWindow = NSStringFromClass(testWindow.classForCoder)
            if topWindow == "UIRemoteKeyboardWindow" {
            } else {
                keyboardWindow = testWindow
            }
       }
        return keyboardWindow!
    }
    
    /*
    func keyboardHeight() -> Float {
        var keyboardWindow: UIWindow? = nil
        for testWindow: UIWindow in UIApplication.shared.windows {
            if !testWindow.self.isEqual(UIWindow.self) {
                keyboardWindow = testWindow
                break
            }
        }
        
        for possibleKeyboard: UIView in keyboardWindow?.subviews ?? [] where possibleKeyboard is UIView {
            var viewName =  String(describing: possibleKeyboard.self)
            
            if viewName.hasPrefix("UI") {
                if viewName.hasSuffix("PeripheralHostView") || viewName.hasSuffix("Keyboard") {
                    return Float(possibleKeyboard.bounds.height)
                } else if viewName.hasSuffix("InputSetContainerView") {
                    for possibleKeyboardSubview: UIView in possibleKeyboard.subviews {
                        viewName =  String(describing: possibleKeyboard.self)
                        if viewName.hasPrefix("UI") && viewName.hasSuffix("InputSetHostView") {
                            return Float(possibleKeyboardSubview.bounds.height)
                        }
                    }
                }
            }
        }
        return 0.0
    } */
}
