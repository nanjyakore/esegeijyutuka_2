//
//  title.swift
//  esegeijyutuka_1
//
//  Created by kihiro moriya on 2020/12/12.
//

import AVFoundation

class Audio{
    
    var audioPlayer = AVAudioPlayer()
    

    

    func set(named: String, volume:Float = 1.0 ,loop: Int = 0){
        let path = Bundle.main.path(forResource: named, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.volume = volume
            audioPlayer.numberOfLoops = loop
            audioPlayer.prepareToPlay()
        }catch{
            Swift.print("error")
        }
        
        
    }
    func play() {
        audioPlayer.currentTime = 0 // 前の音が流れている状態でplay()をしたとき，前の音が鳴り終わる前に次の音を流す
        audioPlayer.play()
    }

    //音声ファイル停止
    func stop() {
        audioPlayer.stop()
    }

}
