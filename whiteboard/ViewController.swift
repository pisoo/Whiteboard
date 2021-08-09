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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .cyan
        addWhiteboardView()
    }

    func addWhiteboardView() {
        
        whiteboardView = WhiteboardView.init()        
        view.addSubview(whiteboardView)
        whiteboardView.snp.makeConstraints{ (make) -> Void in
            make.top.left.equalTo(view).offset(80)
            make.bottom.right.equalTo(view).offset(-80)
        }
    }

}

