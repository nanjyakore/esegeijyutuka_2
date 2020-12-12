//
//  kekkahappyou.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/10.
//

import UIKit


class kekkahappyou: UIViewController {
    var namae_array:[String]=[]
    var touhyou_count:[Int]=[]
    var userdefaults = UserDefaults()
    
    var jinrou:Int=0
    
    var judgement:[String]=[]
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namae_array = userdefaults.array(forKey: "namae") as! [String]
        
        jinrou = userdefaults.integer(forKey:"jinrou_name")
        
        touhyou_count =
            userdefaults.array(forKey: "touhyoukekka")as![Int]
        //合体
        let data = zip(namae_array, touhyou_count)
        //(0番目のtouhyou_countと１番目のtouhyou_countを比較)
        //?.1(touhyouの方だけもらう)
        //??0(else→nulだったら0という値を採用)
        let maxResult = data.max(by: ({ $0.1 < $1.1 }))?.1 ?? 0
        print(maxResult)
        //最大スコア
        
        
        // judgement
        //data.filter { $0.1 >= maxResult }→(0番目のtouhyou_countとmaxResultを比較)
        //.map(残った方から.0のほうだけ取り出す)
        
        //filterで出したものはプレイヤーとスコア両方はいったもの
        //.mapでスコアの方だけ取り出す
        judgement = data.filter { $0.1 >= maxResult }.map { $0.0 }
        print(judgement)
        //最大スコアだったやつら
        
        
        
        
        
        
        
        label.text = judgement.joined(separator: "")
        
        
        
    }
    
    // Do any additional setup after loading the view.
    
    
    @IBAction func syokei(_ sender: Any) {
        
        if judgement.joined(separator: "") == namae_array[jinrou-1]{
            
            userdefaults.set(judgement.joined(separator:""), forKey: "kotae")
            
            performSegue(withIdentifier: "kati", sender: nil)
        }
        
        else{
            performSegue(withIdentifier: "make_hazusi_1", sender: nil)
        }
        
        
    }
}
