//
//  syutudai.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/09.
//

import UIKit

class syutudai: UIViewController{

    
    @IBOutlet weak var next_1: UIButton!
    @IBOutlet weak var textfield_1: UITextField!
    @IBOutlet weak var textfield_2: UITextField!
    @IBOutlet weak var tap: UIButton!
    @IBOutlet weak var tap_2: UIButton!
    var userdefaults = UserDefaults()
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        next_1.isHidden = true

        // Do any additional setup after loading the view.
       
        
        
        
 
    }
    

   
    @IBAction func button_1(_ sender: Any) {
        count += 1
        if count == 2{
            next_1.isHidden = false
        }
        textfield_1.resignFirstResponder()
        tap.isHidden = true
        userdefaults.set(textfield_1.text, forKey: "odai")
        
        
        }
    
    @IBAction func button_2(_ sender: Any) {
        count += 1
        if count == 2{
            next_1.isHidden = false
        }
        textfield_2.resignFirstResponder()
        tap_2.isHidden = true
        userdefaults.set(textfield_2.text,forKey: "jyanru")
    }
}
