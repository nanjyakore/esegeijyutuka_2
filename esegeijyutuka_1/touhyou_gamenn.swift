//
//  syutudai.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/09.
//

import UIKit

class touhyou_gamenn:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var namae_label: UILabel!
    var userdefaults = UserDefaults()
    var namae_array:[String]=[]
    var touhyou_count: Int = 0
    var touhyou_array:[Int]=[]
    var judgement :[String]=[]
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        
        
        
        
        namae_array = userdefaults.array(forKey: "namae") as! [String]
        //名前初期値
        namae_label.text = namae_array[0]
        //人数分の要素数の配列初期化
        // repeating ... どの値を最初に入れるか→最初に0がすべての要素に入る
        //count ... 配列の大きさ
        touhyou_array = [Int](repeating: 0, count: namae_array.count)
        
        tableview.reloadData()
    }
    //cellをいくつつかいますか？
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namae_array.count
    }
    //todo配列の何番目をどこのセルに入力するか？
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = namae_array[indexPath.row]
        //        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.imageView!.image = UIImage(named: "漫画家のアイコン1")
        
        
        //ボタン生成
        let addbutton = UIButton()
        addbutton.setTitle("投票", for: UIControl.State.normal)
        addbutton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        addbutton.setTitleColor(UIColor.blue, for: UIControl.State.highlighted)
        //その時の行をtagに代入
        addbutton.tag = indexPath.row
        // 押下時動作
        addbutton.addTarget(self, action: #selector(button_action), for: UIControl.Event.touchUpInside)
        
        addbutton.frame = CGRect(x:300, y:0, width:50, height: 50)
        cell.addSubview(addbutton)
        
        
        
        
        //作ったcellを返す
        return cell
    }
    //tips センダーはボタンだった！！
    @IBAction func button_action(_ sender: UIButton) {
        
        
        touhyou_count+=1
        
        
        
        
        
        touhyou_array[sender.tag]+=1
        
        if touhyou_count == namae_array.count{
            userdefaults.set(touhyou_array, forKey: "touhyoukekka")
            
            //合体
            let data = zip(namae_array, touhyou_array)
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
            
            
            
            
            
            if judgement.count>1{
                performSegue(withIdentifier: "make_hukusuu", sender: nil)
            }
            else{
                performSegue(withIdentifier: "kaitou", sender: nil)
            }
            
        }
        else{
            namae_label.text = namae_array[touhyou_count]
        }
        
        
        
    }
}
