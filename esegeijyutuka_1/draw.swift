/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 `DrawingViewController` is the primary view controller for showing drawings.
 */

///`PKCanvasView` is the main drawing view that you will add to your view hierarchy.
/// The drawingPolicy dictates whether drawing with a finger is allowed.  If it's set to default and if the tool picker is visible,
/// then it will respect the global finger pencil toggle in Settings or as set in the tool picker.  Otherwise, only drawing with
/// a pencil is allowed.

/// You can add your own class as a delegate of PKCanvasView to receive notifications after a user
/// has drawn or the drawing was updated. You can also set the tool or toggle the ruler on the canvas.

/// There is a shared tool picker for each window. The tool picker floats above everything, similar
/// to the keyboard. The tool picker is moveable in a regular size class window, and fixed to the bottom
/// in compact size class. To listen to tool picker notifications, add yourself as an observer.

/// Tool picker visibility is based on first responders. To make the tool picker appear, you need to
/// associate the tool picker with a `UIResponder` object, such as a view, by invoking the method
/// `UIToolpicker.setVisible(_:forResponder:)`, and then by making that responder become the first

/// Best practices:
///
/// -- Because the tool picker palette is floating and moveable for regular size classes, but fixed to the
/// bottom in compact size classes, make sure to listen to the tool picker's obscured frame and adjust your UI accordingly.

/// -- For regular size classes, the palette has undo and redo buttons, but not for compact size classes.
/// Make sure to provide your own undo and redo buttons when in a compact size class.

import UIKit
import PencilKit

var flag_1 :Bool = false
var end_flag :Bool = false

extension PKCanvasView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
        print("新しいbegan")
        flag_1 = true
        
    }
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesMoved(touches, with: event)
        print("新しいmoved")
        
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesEnded(touches, with: event)
        
        
        print("新しいend")
        end_flag = true
    }
}



class draw: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScreenshotServiceDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var next_turn: UIButton!
    @IBOutlet weak var namae_label: UILabel!
    @IBOutlet weak var iro_label: UILabel!
    
    @IBOutlet weak var canvasView: PKCanvasView!
    var userdefaults = UserDefaults()
    var toolPicker: PKToolPicker!
    var namae_array:[String]=[]
    var choice : [UIColor] = []
    var flag :Bool = false
    var kaisuu :Int = 0
    var timer : Timer!
    //何周目か記録する変数
    var turn_syuuki :Int = 0
    //choiceを平仮名の色に変換して格納するやつ
    var iro_hiragana : [String] = []
    
    /// On iOS 14.0, this is no longer necessary as the finger vs pencil toggle is a global setting in the toolpicker
    
    /// Standard amount of overscroll allowed in the canvas.
    static let canvasOverscrollHeight: CGFloat = 500
    
    /// Data model for the drawing displayed by this view controller.
    
    /// Private drawing state.
    var drawingIndex: Int = 0
    var hasModifiedDrawing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval:0.01, repeats: true, block: { (t) in
            if end_flag == true{
                self.next_turn.isHidden = false
                self.canvasView.drawingPolicy = PKCanvasViewDrawingPolicy.default
                
            }
        })
        
        label.text = userdefaults.string(forKey: "jyanru")
        
        next_turn.isHidden = true
        
        //？
        namae_array = userdefaults.array(forKey: "namae") as! [String]
        
        
        
        if let data = UserDefaults.standard.object(forKey: "color") as? Data {
            if let restoredColor = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as?
                [UIColor] {
                //ここでrestoredColorが使える
                choice = restoredColor
                
                
            }
            
            
            
        }
        //choiceを平仮名の色に変換して格納するやつ
        //        [UIColor.red,
        //                                UIColor.blue,
        //                                UIColor.brown,
        //                                UIColor.green,
        //                                UIColor.orange,
        //                                UIColor.purple,
        //                                UIColor.yellow,
        //                                UIColor.magenta,
        //                                UIColor.cyan]
        
        for i in 0..<choice.count{
            switch choice[i]{
            case UIColor.blue:
                iro_hiragana.append("青")
            case UIColor.brown:
                iro_hiragana.append("茶色")
            case UIColor.green:
                iro_hiragana.append("緑")
            case UIColor.orange:
                iro_hiragana.append("オレンジ")
            case UIColor.red:
                iro_hiragana.append("赤")
            case UIColor.purple:
                iro_hiragana.append("紫")
            case UIColor.yellow:
                iro_hiragana.append("黄色")
            case UIColor.magenta:
                iro_hiragana.append("magenta")
            case UIColor.cyan:
                iro_hiragana.append("cyan")
                
            default:
                print("かす")
            }
            
        }
        
        
        
        
        //        for i in choice{
        //            if choice[i] == UIColor.red{
        //                iro_hiragana.append("赤")
        //
        //            }
        //        }
        
        
        namae_label.text = namae_array[0]
        
        
        iro_label.text = iro_hiragana[0]
        
        
        
        
        
    }
    
    
    
    
    /// Set up the drawing initially.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set up the canvas view with the first drawing from the data model.
        canvasView.delegate = self
        canvasView.isScrollEnabled = false
        
        canvasView.alwaysBounceVertical = true
        
        //色初期値
        canvasView.tool = PKInkingTool(.pen,color: choice[0],width: 30)
        
        //全部かける（指もペンも）
        canvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        
        //ツールピッカー
        //Set up the tool picker
        //        if #available(iOS 14.0, *) {
        //            toolPicker = PKToolPicker()
        //        } else {
        //            // Set up the tool picker, using the window of our parent because our view has not
        //            // been added to a window yet.
        //            let window = parent?.view.window
        //            toolPicker = PKToolPicker.shared(for: window!)
        //        }
        //
        //        toolPicker.setVisible(true, forFirstResponder: canvasView)
        //
        //
        //        toolPicker.addObserver(canvasView)
        //        toolPicker.addObserver(self)
        
        canvasView.becomeFirstResponder()
        
        // Add a button to sign the drawing in the bottom right hand corner of the page
        
        
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>,with event: UIEvent?){
        
        print("古いbegan")
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesMoved(touches, with: event)
        
        
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>,with event: UIEvent?){
        
        //
        //        if flag_1 == true{
        //            next_turn.isHidden = false
        //            canvasView.drawingPolicy = PKCanvasViewDrawingPolicy.default
        
        
        print ("touchend")
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func next(_ sender: Any) {
        end_flag = false
        flag_1 = false
        canvasView.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        
        next_turn.isHidden = true
        kaisuu+=1
        if kaisuu>=namae_array.count{
            if turn_syuuki == 1{
                
                let unit = self.view.frame.width
                let image = canvasView?.drawing.image(from: CGRect(x: 0, y: 0, width: unit * 2, height: unit * 2), scale: 1.0)
                let saveImage = try! NSKeyedArchiver.archivedData(withRootObject:image ?? UIImage(), requiringSecureCoding: false)
                UserDefaults.standard.set(saveImage, forKey: "image")
                UserDefaults.standard.synchronize()
                
                //結果画面
                performSegue(withIdentifier: "kekka", sender: nil)
            }
            else{
                turn_syuuki+=1
            }
            
            kaisuu = 0
        }
        
        
        namae_label.text = namae_array[kaisuu]
        iro_label.text = iro_hiragana[kaisuu]
        canvasView.tool = PKInkingTool(.pen,color: choice[kaisuu],width: 30)
        
        
        
    }
}

