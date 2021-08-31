//
//  RightView.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/31.
//

import UIKit

class RightView: UIView {
    
    var imageViews: [UIImageView]?
    var imageView0: UIImageView!
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    
    func addImageView(_ image: UIImage, _ size: CGSize) {
        
        var imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        imageView.image = image
        imageView.tag = 100 + (imageViews?.count ?? 0)
        addSubview(imageView)
        imageViews?.append(imageView)
        
        imageView.isUserInteractionEnabled = true
        let panGestureRecognizer = UIPanGestureRecognizer.init(target: self,
                                                               action: #selector(panHandler))
        imageView.addGestureRecognizer(panGestureRecognizer)
        
        
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self,
                                                              action: #selector(pinchHandler))
        pinchGestureRecognizer.delegate = self
        imageView.addGestureRecognizer(pinchGestureRecognizer)
        
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self,
                                                                    action: #selector(rotateView))
        rotationGestureRecognizer.delegate = self
        imageView.addGestureRecognizer(rotationGestureRecognizer)
    }
    
    @objc func panHandler(gestureRecognizer: UIPanGestureRecognizer?) {
        
        // 超过 rightView 不能操作
//        if let view = gestureRecognizer?.view {
//            if view.frame.origin.x > 0 && view.frame.origin.y > 0 {
//                return
//            }
//        }
        
        // 移动到最上面
        if let view = gestureRecognizer?.view {
            self.bringSubviewToFront(view)
        }
        
        if gestureRecognizer?.state == .changed {
            
            let translation = gestureRecognizer?.translation(in: self)
            gestureRecognizer?.view?.center = CGPoint(x: (gestureRecognizer?.view?.center.x ?? 0.0) + (translation?.x ?? 0.0),
                                                      y: (gestureRecognizer?.view?.center.y ?? 0.0) + (translation?.y ?? 0.0))
            gestureRecognizer?.setTranslation(CGPoint.zero, in: self)
        }
    }
    
    @objc func pinchHandler(gestureRecognizer: UIPinchGestureRecognizer?) {
        
        let view = gestureRecognizer?.view
        if gestureRecognizer?.state == .began || gestureRecognizer?.state == .changed {
            if let transform = view?.transform.scaledBy(x: gestureRecognizer?.scale ?? 0.0, y: gestureRecognizer?.scale ?? 0.0) {
                view?.transform = transform
            }
            gestureRecognizer?.scale = 1
        }
    }
    
    @objc func rotateView(gestureRecognizer: UIRotationGestureRecognizer?) {
        
        let view = gestureRecognizer?.view
        if gestureRecognizer?.state == .began || gestureRecognizer?.state == .changed {
            if let transform = view?.transform.rotated(by: gestureRecognizer?.rotation ?? 0.0) {
                view?.transform = transform
            }
            gestureRecognizer?.rotation = 0
        }
    }
    
    
    func updateImageView(_ image: UIImage, _ size: CGSize) {
        
        imageView0 = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        imageView0.image = image
        self.addSubview(imageView0)
    }
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: ui
}

extension RightView: UIGestureRecognizerDelegate {
    
    // 允许同时识别在同一视图上的特定手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let gestureRecognizerView = gestureRecognizer.view, let otherGestureRecognizerView = otherGestureRecognizer.view {
            if (gestureRecognizerView is UIImageView) && (otherGestureRecognizerView is UIImageView) && (gestureRecognizerView.tag == otherGestureRecognizerView.tag) {
                return true
            }
        }
        return false
    }
    
}
