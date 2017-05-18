//
//  CustomButton.swift
//  test.1
//
//  Created by Dik on 21.02.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit

  class CustomButton: UIButton {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setTitle(NumberFormatter().currencyDecimalSeparator, for: UIControlState())
        layer.cornerRadius = 10
        layer.borderWidth = 5
        clipsToBounds = true
    }
    
    
}


 class AllButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 5
        self.clipsToBounds = true
        
    }
    
    
}

