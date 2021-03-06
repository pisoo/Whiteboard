//
//  LeftView.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/24.
//

import UIKit
import Combine

class LeftView: UIView {
    
    var scrollView: UIScrollView!
    var imageView0: TestImageView!
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    
    var maxContentWidth: CGFloat = 0
    var maxContentHeight: CGFloat = 0
    var cancellable: Cancellable?
    
    //
    var contentWidthConstraint: NSLayoutConstraint!
    var contentHeightConstraint: NSLayoutConstraint!
    
    var areaView: UIView!
        
    var finishScreenshot: ((_ image: UIImage?, _ size: CGSize) -> ())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        addObj()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addViews()
        addObj()
    }
    
    func addViews() {
        
        scrollView = UIScrollView.init(frame: self.bounds)
        scrollView.backgroundColor = .orange
        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.widthAnchor.constraint(equalToConstant: UIScreen.currentWidth()).isActive = true
//        scrollView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                        
        imageView0 = TestImageView.init(frame: CGRect.zero)
        imageView0.isUserInteractionEnabled = true
        imageView0.image = UIImage.init(named: "0")!
        scrollView.addSubview(imageView0)
        imageView0.screenshotCompletion = { (image, size) -> () in
            self.finishScreenshot(image, size)
            self.imageView0.resetAreaView()
        }
        
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        isPortrait ? updateVerticalViews() : updateHorizontalViews()
    }
    
    func updateVerticalViews()  {
        
        let imageWidth = UIScreen.currentWidth()
        let imageHeight = imageWidth * 4 / 5
        maxContentHeight = imageHeight
        
        imageView0.translatesAutoresizingMaskIntoConstraints = false
        contentWidthConstraint = imageView0.widthAnchor.constraint(equalToConstant: imageWidth)
        contentWidthConstraint.isActive = true
        contentHeightConstraint = imageView0.heightAnchor.constraint(equalToConstant: imageHeight)
        contentHeightConstraint.isActive = true
        imageView0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    func updateHorizontalViews() {
        
        let imageHeight = UIScreen.currentHeight()
        let imageWidth = imageHeight * 5 / 4
        maxContentWidth = imageWidth
        
        imageView0.translatesAutoresizingMaskIntoConstraints = false
        contentWidthConstraint = imageView0.widthAnchor.constraint(equalToConstant: imageWidth)
        contentWidthConstraint.isActive = true
        contentHeightConstraint = imageView0.heightAnchor.constraint(equalToConstant: imageHeight)
        contentHeightConstraint.isActive = true
        imageView0.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    func addObj() {
        
        cancellable = self.publisher(for: \.frame).sink { frame in

            
            let canUpdate = (frame.size != CGSize.zero) || (frame.size.width >= self.maxContentWidth)
            if canUpdate == false { return }
            
            self.updateContentSize()
            
        }
    }
    
    func updateContentSize() {
        
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        
        
        if isPortrait {
            
            contentWidthConstraint.constant = getVerticalContentWidth()
            contentHeightConstraint.constant = getVerticalContentHeight()
        }
        else {
            
            contentWidthConstraint.constant = getHorizontalContentWidth()
            contentHeightConstraint.constant = getHorizontalContentHeight()
        }
        

    }
    
    // vertical
    
    func getVerticalContentWidth() -> CGFloat {
        return getVerticalContentHeight() * 5 / 4

    }
    
    func getVerticalContentHeight() -> CGFloat {
        return (self.bounds.height >= maxContentHeight) ? maxContentHeight : self.bounds.height
    }
    

    // horizontal
    
    func getHorizontalContentWidth() -> CGFloat {
        return (self.bounds.width >= maxContentWidth) ? maxContentWidth : self.bounds.width

    }
    
    func getHorizontalContentHeight() -> CGFloat {
        return getHorizontalContentWidth() * 4 / 5
    }
}






protocol Test {
    
    var coverView: UIView { get }
//    var startPoint: CGPoint { get }
    
    func aaa()
}

extension Test {
    
    var coverView: UIView {
        let view = UIView.init()
        view.backgroundColor = .red
        return view
    }
    

}

extension UIImageView: Test {
    
    var startPoint: CGPoint {
        get {
            return CGPoint.init()
        }
    }
    
    
    
    func aaa() {
        
    }
        
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let isInContent = touches.first?.view?.isDescendant(of: self) {
            if isInContent, let point = touches.first?.location(in: self) {
                
//                self.startPoint = point
            }
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let isInContent = touches.first?.view?.isDescendant(of: self) {
            if isInContent, let point = touches.first?.location(in: self) {
                
                updateSelectedAreaView(movedPoint: point)
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let isInContent = touches.first?.view?.isDescendant(of: self) {
            if isInContent, let point = touches.first?.location(in: self) {
                
                updateSelectedAreaView(movedPoint: point)
            }
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        if let isInContent = touches.first?.view?.isDescendant(of: self) {
            if isInContent, let point = touches.first?.location(in: self) {
                
                updateSelectedAreaView(movedPoint: point)
            }
        }
    }
    
    func updateSelectedAreaView(movedPoint: CGPoint) {
        
        let starX = (self.startPoint.x > movedPoint.x) ? movedPoint.x :  self.startPoint.x
        let starY = (self.startPoint.y > movedPoint.y) ? movedPoint.y :  self.startPoint.y
        let endX = (self.startPoint.x < movedPoint.x) ? movedPoint.x :  self.startPoint.x
        let endY = (self.startPoint.y < movedPoint.y) ? movedPoint.y :  self.startPoint.y
        
        self.coverView.frame = CGRect.init(x: starX, y: starY, width: endX - starX, height: endY - starY)
    }
}
