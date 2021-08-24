//
//  A.swift
//  Panel
//
//  Created by CPHKEP on 2021/8/17.
//

import UIKit

extension UIViewController {
    
    
    
    @objc func targetViewDidSlide(_ touches: Set<UITouch>)  {
    }
    
    // MARK: touch
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        targetViewDidSlide(touches)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        targetViewDidSlide(touches)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        targetViewDidSlide(touches)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        targetViewDidSlide(touches)
    }
    
}
