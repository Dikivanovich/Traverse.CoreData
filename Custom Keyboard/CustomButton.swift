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
        layer.cornerRadius = 5
        layer.borderWidth = 2
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        clipsToBounds = true
    }
    
    
}


class AllButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.clipsToBounds = true
        
    }
    
    
}

