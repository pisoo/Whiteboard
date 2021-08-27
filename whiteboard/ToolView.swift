//
//  ToolView.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/24.
//

import UIKit

class ToolView: UIView {
    
    var screenshotsButton: UIButton!      // 截图
    var brushButton: UIButton!            // 画笔
    var eraserButton: UIButton!           // 橡皮擦
    var undoButton: UIButton!             // 撤销
    var redoButton: UIButton!             // 恢复
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addViews()
    }
    
    func addViews() {
        
        screenshotsButton = UIButton.init(type: .custom)
        screenshotsButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 60)
        self.addSubview(screenshotsButton)
        
        
    }
    
    
    
    
}
