//
//  MyCustomKeyboard.swift
//  test.1
//
//  Created by Dik on 21.02.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import Foundation


 class MyCustomKeyboard: UIView {
    
    static let instance = MyCustomKeyboard()
  
    var view: UIView!

    var nibName: String = "MyCustomKeyboard"

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
        layer.backgroundColor = UIColor.clear.cgColor
        setup()
        
   
    }
    
    func loadFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
       
    }
    func setup() {
        
        view = loadFromNib()
        view.frame = bounds
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
    }
    
    deinit {
        print("экземпляр класса MyCustomKeyboard удален")
    }
    
    
}
