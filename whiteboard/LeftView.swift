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
    var imageView0: UIImageView!
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    
    var maxContentWidth: CGFloat = 0
    var cancellable: Cancellable?
    
    //
    var contentWidthConstraint: NSLayoutConstraint!
    var contentHeightConstraint: NSLayoutConstraint!
    
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
        
        
        let imageHeight = UIScreen.currentHeight() - 60
        let imageWidth = imageHeight * 5 / 4
        maxContentWidth = imageWidth
        
        imageView0 = UIImageView.init()
        imageView0.image = UIImage.init(named: "0")!
        scrollView.addSubview(imageView0)
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
        
        contentWidthConstraint.constant = getContentWidth()
        contentHeightConstraint.constant = getContentHeight()
    }

    func getContentWidth() -> CGFloat {
        return (self.bounds.width >= maxContentWidth) ? maxContentWidth : self.bounds.width

    }
    
    func getContentHeight() -> CGFloat {
        return getContentWidth() * 4 / 5
    }
}

