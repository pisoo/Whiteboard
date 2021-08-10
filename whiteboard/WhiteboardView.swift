//
//  WhiteboardView.swift
//  whiteboard
//
//  Created by CPHKEP on 2021/8/9.
//

import UIKit

class WhiteboardView: UIView {
    
    
    var isAdd = false
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        customLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ui
    
    func customLayout() {
        
        self.backgroundColor = .red
    }
    
  
}
