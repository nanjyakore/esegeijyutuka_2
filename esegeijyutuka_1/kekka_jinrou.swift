//
//  kekka_jinrou.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/13.
//

import UIKit

class kekka_jinrou: UIViewController {
    var audio = Audio()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audio.set(named: "zenmetu")
        audio.play()
        

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

    @IBAction func title(_ sender: Any) {
        audio.stop()
    }
}
