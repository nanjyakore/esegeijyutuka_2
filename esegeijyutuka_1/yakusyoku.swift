//
//  yakusyoku.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/09.
//

import UIKit

class yakusyoku: UIViewController {
    var userdefaults = UserDefaults()
    var count :Int = 0
    var kaisuu : Int = 0
    var jinrou :Int = 0
    var odai : String = ""
    var namaes : [String] = []
    var color :[UIColor] = [UIColor.red,
                            UIColor.blue,
                            UIColor.brown,
                            UIColor.green,
                            UIColor.orange,
                            UIColor.purple,
                            UIColor.yellow,
                            UIColor.magenta,
                            UIColor.cyan]
    var choice : [UIColor] = []
    
    @IBOutlet weak var ninme: UILabel!
    @IBOutlet weak var label_odai: UILabel!
    @IBOutlet weak var haikei: UIView!
    @IBOutlet weak var next_button: UIButton!
    @IBOutlet weak var jinrou_text: UILabel!
    @IBOutlet weak var geijyutuka_text: UILabel!
    
    @IBOutlet weak var geijyutuka: UIImageView!
    @IBOutlet weak var ookami: UIImageView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var ninzuu_1: UILabel!
    @IBOutlet weak var kettei_1: UIButton!
    @IBOutlet weak var odaiha: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        odaiha.isHidden = true
        
        label_odai.isHidden = true
        
        
        label_odai.text =  userdefaults.string(forKey: "odai")
        
        
        ninzuu_1.text = String(kaisuu+1)
        
        geijyutuka_text.isHidden = true
        jinrou_text.isHidden = true
        ookami.isHidden = true
        geijyutuka.isHidden = true
        count = userdefaults.integer(forKey: "ninzuu")
        jinrou = Int.random(in: 1..<count-1)
        
        userdefaults.set(jinrou,forKey:"jinrou_name")
        
        choice = Array(color[0..<count-1].shuffled())
        
        //きもい
        let saveColor = try! NSKeyedArchiver.archivedData(withRootObject: choice,requiringSecureCoding: false)
        UserDefaults.standard.set(saveColor, forKey: "color")
        UserDefaults.standard.synchronize()

//        userdefaults.set(choice, forKey: "color")
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func kettei(_ sender: Any) {
        text.resignFirstResponder()
        ninme.isHidden = true
        ninzuu_1.isHidden = true
        
        haikei.backgroundColor = choice[kaisuu]
        kaisuu+=1
        
        namaes.append(text.text!)
        text.resignFirstResponder()
        text.isHidden = true
        kettei_1.isHidden = true
        next_button.isHidden = false
        if kaisuu == jinrou{
            odaiha.isHidden = true
            label_odai.isHidden = true
            ookami.isHidden = false
            jinrou_text.isHidden = false
        }
        else{
            odaiha.isHidden = false
            label_odai.isHidden = false
            geijyutuka.isHidden = false
            geijyutuka_text.isHidden = false
            
        }
        
    
    }
    @IBAction func next(_ sender: Any) {
        ninme.isHidden = false
        ninzuu_1.isHidden = false
        odaiha.isHidden = true
        label_odai.isHidden = true
        ookami.isHidden = true
        geijyutuka.isHidden = true
        text.isHidden = false
        kettei_1.isHidden = false
        jinrou_text.isHidden = true
        geijyutuka_text.isHidden = true
        ninzuu_1.text = String(kaisuu+1)
        next_button.isHidden = true
        
        text.text = ""
        haikei.backgroundColor = UIColor.white
        
        if kaisuu == count-1{
            userdefaults.set(namaes, forKey: "namae")
            
            performSegue(withIdentifier: "game", sender: nil)
        }
        
    }
}
