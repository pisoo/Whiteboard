//
//  MainController.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/24.
//

import UIKit

class MainController: UIViewController {
    
    var toolView: UIView!
    var leftView: LeftView!
    var rightView: RightView!
    var slideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
        addActions()
        aaa()
        
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        isPortrait ? updateVerticalViews() : updateHorizontalViews()
    }
    
    func aaa() {
        
        self.leftView.finishScreenshot = { (image, size) -> () in
//            self.rightView.addImageView(image!, size)
            
            
//            let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
//            let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
//            isPortrait ? self.updateAnimateVerticalViews(0.25) : self.updateAnimatHorizontalViews(0.25)
        }
    }
    
    
    func addActions() {
        
//        leftView.goButton.addTarget(self,
//                                    action: #selector(goClicked),
//                                    for: .touchUpInside)
        
        
        
    }
    
    @objc func goClicked() {
        
//        leftView.inputField.resignFirstResponder()
//        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
//        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
//        slideView.isHidden = false
//        isPortrait ? updateAnimateVerticalViews(0.25) : updateAnimatHorizontalViews(0.25)
//
//        let url = leftView.inputField.text!
//        let request = URLRequest.init(url: URL.init(string: "https:" + url)!)
//        rightView.webView.load(request)
    }
    
    // MARK: 滑动
    
    override func targetViewDidSlide(_ touches: Set<UITouch>) {
        super.targetViewDidSlide(touches)
        
        print("AAA")
        
        if slideView.isHidden == true { return }
        if let isInSlideView = touches.first?.view?.isDescendant(of: slideView) {
            if isInSlideView, let point = touches.first?.location(in: self.view) {
                                                
                // 旋转屏幕结束
                let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
                let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
                isPortrait ? updateSlideVerticalViews(point) : updateSlideHorizontalViews(point)
            }
        }
    }
    
    func updateSlideVerticalViews(_ point: CGPoint) {
        
        if point.y == UIScreen.currentHeight() {
            slideView.isHidden = true
        }
        
        if point.y < UIScreen.currentHeight() * 0.3 { return }
        
        leftView.frame.size.height = point.y
            
        rightView.frame.origin.y = point.y
        rightView.frame.size.height = UIScreen.currentHeight() - point.y
            
        slideView.frame.origin.y = point.y - 60
    }
    
    
    func updateSlideHorizontalViews(_ point: CGPoint) {
        
        if point.x == UIScreen.currentWidth() {
            slideView.isHidden = true
        }
        
        if point.x < UIScreen.currentWidth() * 0.2 { return }

        leftView.frame.size.width = point.x
            
        rightView.frame.origin.x = point.x
        rightView.frame.size.width = UIScreen.currentWidth() - point.x
            
        slideView.frame.origin.x = point.x - 60
    }
    
    
    // MARK: 旋转屏幕
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        isPortrait ? updateAnimateVerticalViews(coordinator.transitionDuration) : updateAnimatHorizontalViews(coordinator.transitionDuration)
    }
    
    
    // MARK: ui
    
    func addViews() {
        
        rightView = RightView.init()
//        rightView.backgroundColor = .blue
        view.addSubview(rightView)
        
        toolView = UIView.init()
        toolView.backgroundColor = .red
//        view.addSubview(toolView)
        
        leftView = LeftView.init()
        leftView.backgroundColor = .lightGray
        view.addSubview(leftView)
        

        
        slideView = UIView.init()
        slideView.backgroundColor = .green
//        slideView.isHidden = true
        view.addSubview(slideView)
    }
    
    func updateVerticalViews() {
        
        toolView.frame = CGRect.init(x: 0,
                                     y: 0,
                                     width: UIScreen.currentWidth(),
                                     height: 60)
        
        leftView.frame = CGRect.init(x: 0,
                                     y: 0,
                                     width: UIScreen.currentWidth(),
                                     height: UIScreen.currentHeight())
        
        rightView.frame = CGRect.init(x: 0,
                                      y: UIScreen.currentHeight(),
                                      width: UIScreen.currentWidth(),
                                      height: 0)
        
        slideView.frame = CGRect.init(x: UIScreen.currentWidth() * 0.5 - 30,
                                      y: UIScreen.currentHeight() - 60,
                                      width: 60,
                                      height: 60)
    }
    
    func updateHorizontalViews() {
        
        toolView.frame = CGRect.init(x: 0,
                                     y: 0,
                                     width: UIScreen.currentWidth(),
                                     height: 60)
                
        leftView.frame = CGRect.init(x: 0,
                                     y: 0,
                                     width: UIScreen.currentWidth(),
                                     height: UIScreen.currentHeight() )
        
        rightView.frame = CGRect.init(x: UIScreen.currentWidth(),
                                      y: 0,
                                      width: 0,
                                      height: UIScreen.currentHeight())
        
        slideView.frame = CGRect.init(x: UIScreen.currentWidth() - 60,
                                      y: UIScreen.currentHeight() * 0.5 - 30,
                                      width: 60,
                                      height: 60)
    }
    
    
    func updateAnimateVerticalViews(_ animateDuration: TimeInterval) {
        
        UIView.animate(withDuration: animateDuration) {

            
            
            if self.rightView.frame.size.width == 0 {
                self.updateVerticalViews()
            }
            else {
                
                self.slideView.isHidden = false
                
                self.leftView.frame = CGRect.init(x: 0,
                                                  y: 0,
                                                  width: UIScreen.currentWidth(),
                                                  height: UIScreen.currentHeight() * 0.5)
                
                self.rightView.frame = CGRect.init(x: 0,
                                                   y: UIScreen.currentHeight() * 0.5,
                                                   width: UIScreen.currentWidth(),
                                                   height: UIScreen.currentHeight() * 0.5)
                
                self.slideView.frame = CGRect.init(x: UIScreen.currentWidth() * 0.5 - 30,
                                                   y: UIScreen.currentHeight() * 0.5 - 60,
                                                   width: 60,
                                                   height: 60)
            }
            
        } completion: { finish in
            
            // 更新 content 显示
            self.leftView.imageView0.removeConstraints(self.leftView.imageView0.constraints)
            self.leftView.updateHorizontalViews()
        }
    }
    
    func updateAnimatHorizontalViews(_ animateDuration: TimeInterval) {
        
        UIView.animate(withDuration: animateDuration) {
            
            if self.rightView.frame.size.height == 0 {
                self.updateHorizontalViews()
            }
            else {
                
                self.slideView.isHidden = false
                
                self.leftView.frame = CGRect.init(x: 0,
                                                  y: 0,
                                                  width: UIScreen.currentWidth() * 0.5,
                                                  height: UIScreen.currentHeight())
                
                self.rightView.frame = CGRect.init(x: UIScreen.currentWidth() * 0.5,
                                                   y: 0,
                                                   width: UIScreen.currentWidth() * 0.5,
                                                   height: UIScreen.currentHeight())
                
                self.slideView.frame = CGRect.init(x: UIScreen.currentWidth() * 0.5 - 60,
                                                   y: UIScreen.currentHeight() * 0.5 - 30,
                                                   width: 60,
                                                   height: 60)
            }
            

        } completion: { finish in
            
            // 更新 content 显示
            self.leftView.imageView0.removeConstraints(self.leftView.imageView0.constraints)
            self.leftView.updateHorizontalViews()
        }
    }
    
    
    
}


extension UIScreen {
    
    static func currentWidth() -> CGFloat {

        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        if isPortrait {
            return (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
        }
        else {
            return (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
        }
        
    }
    
    
    static func currentHeight() -> CGFloat {

        let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        let isPortrait = (orientation == .portrait) || (orientation == .portraitUpsideDown)
        if isPortrait {
            return (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
        }
        else {
            return (UIScreen.main.bounds.height > UIScreen.main.bounds.width) ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
        }
        
    }
    
    
    static func isPortrait() -> Bool {
        let orientation = UIApplication.shared.statusBarOrientation
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) {
            return true
        }
        return false
    }
        
}
