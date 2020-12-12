//
//  jinrou_happyou.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/11.
//

import UIKit

class jinrou_happyou: UIViewController {
    
    @IBOutlet weak var kekkagazou: UIImageView!
    @IBOutlet weak var textfield: UITextField!

    @IBOutlet weak var label_jinrou: UILabel!
    var kotae:String=""
    var userdefaults = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //画像呼び出し
        if let data = UserDefaults.standard.object(forKey: "image") as? Data {
            if let image = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIImage {
                 kekkagazou.image = image
            }
        }
//        test.font = UIFont(name:"TsukuARdGothic-Regular",size:12)
        
        kotae = userdefaults.string(forKey: "kotae")!
        
        label_jinrou.text = kotae

        
        
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
    @IBAction func tap(_ sender: Any) {
        textfield.resignFirstResponder()
        if textfield.text == ""{
            return
        }
        else if textfield.text == userdefaults.string(forKey: "odai"){
            performSegue(withIdentifier: "katikatiyama", sender: nil)
        }
        else{
            performSegue(withIdentifier: "kati_geijyutuka", sender: nil)
        }
    
    }
    
}
