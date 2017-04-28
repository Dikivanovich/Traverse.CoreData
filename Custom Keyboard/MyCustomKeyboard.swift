//
//  MyCustomKeyboard.swift
//  test.1
//
//  Created by Dik on 21.02.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import Foundation

protocol KeyboardDelegate  {
    
    func keyWasTapped(_ text: UIButton)
}



class MyCustomKeyboard: UIView {
    
    static let instance = MyCustomKeyboard()
  
    
    
    
  
    
    
   
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var buttonFour: UIButton!
    
    @IBOutlet weak var buttonFive: UIButton!
    
    @IBOutlet weak var buttonSix: UIButton!
    
    @IBOutlet weak var buttonSeven: UIButton!
    
    @IBOutlet weak var buttonEight: UIButton!
    
    @IBOutlet weak var buttonNine: UIButton!
    
    @IBOutlet weak var buttonZero: UIButton!
    
    @IBOutlet weak var buttonMinus: UIButton!
    
    @IBOutlet weak var buttonBackSpace: UIButton!
    
    @IBOutlet weak var buttonEnter: UIButton!
    
    @IBOutlet weak var commaButton: UIButton!{
        didSet{
            
            clipsToBounds = true
            layer.borderWidth = 5
            return commaButton.setTitle(NumberFormatter().currencyDecimalSeparator, for: UIControlState())
        }
    }

    

    
    //    MARK: - настройка действий кнопок:
    
    
    
//    @IBAction func pressOne(_ sender: UIButton) {
//        
//       delegate?.keyWasTapped(sender.currentTitle!)
//        print("Нажата клавиша \(sender.currentTitle!)")
//       UserDefaults.standard.mutableSetValue(forKey: "selectedButton")
//        UserDefaults.standard.synchronize()
//        
//    }
    
    @IBAction func pressTwo(_ sender: UIButton) {
        
        delegate?.keyWasTapped(sender)
        print("Нажата клавиша \(sender.currentTitle!)")
        
    }
    
    @IBAction func pressThree(_ sender: Any) {
    }
    
    
    @IBAction func pressFour(_ sender: Any) {
    }
    
    @IBAction func pressFive(_ sender: Any) {
    }
    
    @IBAction func pressSix(_ sender: Any) {
    }
    
    @IBAction func pressSeven(_ sender: Any) {
    }
    
    @IBAction func pressEight(_ sender: Any) {
    }
    
    @IBAction func pressNine(_ sender: Any) {
    }
    
    @IBAction func pressZero(_ sender: Any) {
    }
    
    @IBAction func pressMinus(_ sender: Any) {
    }
    
    @IBAction func pressComma(_ sender: Any) {
    }
    
    @IBAction func pressBackSpace(_ sender: Any) {
    }
    @IBAction func pressEnter(_ sender: Any) {
    }
    
    
    
        
    
    
    
    
// MARK: - Назначение функций по нажатию кнопки button:
 

    
    var view: UIView!

   var delegate: KeyboardDelegate?
    
    var textInputDelegate: UITextInputDelegate?
    
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
    
   
    



    
}
