//
//  ViewController.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/09.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
   
    var count :Int = 5
    var userdefaults = UserDefaults()
    
    @IBOutlet weak var ninzuu: UILabel!
    
    @IBOutlet weak var megane_1: UIImageView!
    @IBOutlet weak var megane_2: UIImageView!
    @IBOutlet weak var megane_3: UIImageView!
    @IBOutlet weak var megane_4: UIImageView!
    @IBOutlet weak var megane_5: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // Do any additional setup after loading the view.
        
        //        megane_1.isHidden=true
        //        megane_2.isHidden=true
        //        megane_3.isHidden=true
        //        megane_4.isHidden=true
        //        megane_5.isHidden=true
    }
    @IBAction func sub(_ sender: Any) {
        if count>5{
            count-=1
            megane_hyouji()
            ninzuu.text=String(count)
        }
    }
    @IBAction func add(_ sender: Any) {
        if count<10{
            count+=1
            megane_hyouji()
            ninzuu.text=String(count)
        }
    }
    
    func megane_hyouji(){
        if count == 6{
            megane_1.isHidden=false
            megane_2.isHidden=true
            megane_3.isHidden=true
            megane_4.isHidden=true
            megane_5.isHidden=true
        }
        if count == 7{
            megane_1.isHidden=false
            megane_2.isHidden=false
            megane_3.isHidden=true
            megane_4.isHidden=true
            megane_5.isHidden=true
        }
        if count == 8{
            megane_1.isHidden=false
            megane_2.isHidden=false
            megane_3.isHidden=false
            megane_4.isHidden=true
            megane_5.isHidden=true
        }
        if count == 9{
            megane_1.isHidden=false
            megane_2.isHidden=false
            megane_3.isHidden=false
            megane_4.isHidden=false
            megane_5.isHidden=true
        }
        if count == 10{
            megane_1.isHidden=false
            megane_2.isHidden=false
            megane_3.isHidden=false
            megane_4.isHidden=false
            megane_5.isHidden=false
        }
        
    }
    
    @IBAction func game_start(_ sender: Any) {
        userdefaults.set(count,forKey: "ninzuu")
        
    }
}

