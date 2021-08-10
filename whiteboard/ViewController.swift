//
//  ViewController.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/9.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var whiteboardView: WhiteboardView!
    var pan: UIPanGestureRecognizer!
    var imageBackgroundView: UIView!
    var imageView: UIImageView!
    let screenWidth = UIScreen.main.bounds.height
    
    var selectedAreaView: UIView!
    var selectedAreaStarPoint: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        adddImageBackgroundView()
        addWhiteboardView()
        addSelectedAreaView()
    }

    func adddImageBackgroundView() {
        
        imageBackgroundView = UIView.init()
        imageBackgroundView.backgroundColor = .blue
        view.addSubview(imageBackgroundView)
        imageBackgroundView.snp.makeConstraints{ (make) -> Void in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(screenWidth * 0.5)
        }
        
        addImageView()
    }
    
    func addImageView() {
        
        imageView = UIImageView.init()
        let originImage = UIImage.init(named: "image")!
//        imageView.image = UIImage.init(named: "image")
        
        // 镜像反转图片
        if let _cgimage = originImage.cgImage {
            let originImage = UIImage.init(cgImage: _cgimage, scale: originImage.scale, orientation: .upMirrored)
            
            imageView.image = originImage
            imageBackgroundView.addSubview(imageView)
            imageView.snp.makeConstraints{ (make) -> Void in
                make.width.equalToSuperview()
                make.height.equalTo(imageView.snp.width)
                make.center.equalToSuperview()
            }
            
        }
//        if let CGImage = backImage.cgImage {
//            backImage = UIImage(
//                cgImage: CGImage,
//                scale: backImage.scale,
//                orientation: .down)
//        }

        
    }

    func addWhiteboardView() {
        
        whiteboardView = WhiteboardView.init()        
        view.addSubview(whiteboardView)
        whiteboardView.snp.makeConstraints{ (make) -> Void in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(screenWidth * 0.5)
        }
        
        pan = UIPanGestureRecognizer.init(target: self,
                                          action: #selector(paned))
        whiteboardView.isUserInteractionEnabled = true
//        whiteboardView.addGestureRecognizer(pan)
    }
    
    func addSelectedAreaView() {
        
        selectedAreaView = UIView.init()
        selectedAreaView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        view.addSubview(selectedAreaView)
        
//        selectedAreaView.snp.makeConstraints{ (make) -> Void in
//            make.top.left.bottom.equalToSuperview()
//            make.width.equalTo(screenWidth * 0.5)
//        }
    }

    @objc func paned(pan: UIPanGestureRecognizer) {
        
        if pan.state == .ended || pan.state == .failed {
            
            let point = pan.translation(in: whiteboardView)
            print("point = \(point)")
        }
    }
    
    // MARK: touch event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print("touchesBegan point = \(String(describing: touches.first?.location(in: self.view)))")
        
        self.selectedAreaStarPoint = touches.first?.location(in: self.view)
//        self.updateSubviews(currentPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        print("touchesMoved point = \(String(describing: touches.first?.location(in: self.view)))")
//        self.updateSubviews(currentPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
        self.updateSelectedAreaView(movedPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        print("touchesEnded point = \(String(describing: touches.first?.location(in: self.view)))")
//        self.updateSubviews(currentPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
        self.updateSelectedAreaView(movedPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        print("touchesCancelled point = \(String(describing: touches.first?.location(in: self.view)))")
//        self.updateSubviews(currentPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
        self.updateSelectedAreaView(movedPoint: touches.first?.location(in: self.view) ?? CGPoint.zero)
    }
    
    
    func updateSubviews(currentPoint: CGPoint) {
        
        let currentX = currentPoint.x
       
        
        
        imageBackgroundView.snp.updateConstraints { (make) in
            make.width.equalTo(currentX)
        }
        
        whiteboardView.snp.updateConstraints { (make) in
            make.width.equalTo(screenWidth-currentX)
        }
    }
    

//    func imageMirrored(originImage: UIImage) -> UIImage {
//        return UIImage.init(cgImage: originImage.cgImage,
//                            scale: originImage.scale,
//                            orientation: .upMirrored)
//    }
    
    
    func updateSelectedAreaView(movedPoint: CGPoint) {
        
        let starX = (self.selectedAreaStarPoint.x > movedPoint.x) ? movedPoint.x :  self.selectedAreaStarPoint.x
        let starY = (self.selectedAreaStarPoint.y > movedPoint.y) ? movedPoint.y :  self.selectedAreaStarPoint.y
        let endX = (self.selectedAreaStarPoint.x < movedPoint.x) ? movedPoint.x :  self.selectedAreaStarPoint.x
        let endY = (self.selectedAreaStarPoint.y < movedPoint.y) ? movedPoint.y :  self.selectedAreaStarPoint.y
        
        selectedAreaView.frame = CGRect.init(x: starX, y: starY, width: endX - starX, height: endY - starY)
    }
}

