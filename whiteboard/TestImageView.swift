//
//  TestImageView.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/30.
//

import UIKit

class TestImageView: UIImageView {
    
    var beginPoint: CGPoint!
    var areaView: UIView!
    
    var buttonCallBack:(() -> ())?
    
    var screenshotCompletion: ((_ image: UIImage?, _ size: CGSize) -> ())!
    
    
    func resetAreaView() {
        
        areaView.alpha = 0.5
        areaView.frame = CGRect.zero
    }

    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
        addViews()
    }
    
    // MARK: ui
    
    func configure() {
        
        self.isUserInteractionEnabled = true
    }
    
    func addViews() {
        
        areaView = UIView.init()
        areaView.backgroundColor = .lightGray
        areaView.alpha = 0.5
        
        self.addSubview(areaView)
    }
    
    
    // MARK: touch
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let point = touches.first?.location(in: self) {
            self.beginPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let point = touches.first?.location(in: self) {
            updateAreaView(movedPoint: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let point = touches.first?.location(in: self) {
            
            updateAreaView(movedPoint: point)
            
            if let image = getCurrentInnerViewShot(nil, atFrame: areaView.frame) {
                screenshotCompletion(image, self.areaView.frame.size)
            }
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        if let point = touches.first?.location(in: self) {
            updateAreaView(movedPoint: point)
            
           
        }
    }
    
   func updateAreaView(movedPoint: CGPoint) {
        
        let starX = (self.beginPoint.x > movedPoint.x) ? movedPoint.x :  self.beginPoint.x
        let starY = (self.beginPoint.y > movedPoint.y) ? movedPoint.y :  self.beginPoint.y
        let endX = (self.beginPoint.x < movedPoint.x) ? movedPoint.x :  self.beginPoint.x
        let endY = (self.beginPoint.y < movedPoint.y) ? movedPoint.y :  self.beginPoint.y
        
        areaView.frame = CGRect.init(x: starX, y: starY, width: endX - starX, height: endY - starY)
    }
    
    
    func getCurrentInnerViewShot(_ innerView: UIView?, atFrame rect: CGRect) -> UIImage? {
      areaView.alpha = 0

      UIGraphicsBeginImageContext(self.frame.size)
      let context = UIGraphicsGetCurrentContext()
      context?.saveGState()
      UIRectClip(rect)
      if let context = context {
        self.layer.render(in: context)
      }
      UIColor.clear.setFill()
      let image = UIGraphicsGetImageFromCurrentImageContext()
      let cgImage = image?.cgImage?.cropping(to: rect)
      var returnImage: UIImage? = nil
      if let cgImage = cgImage {
        returnImage = UIImage(cgImage: cgImage)
      }

      UIGraphicsEndImageContext()
        
      return returnImage
    }
}
