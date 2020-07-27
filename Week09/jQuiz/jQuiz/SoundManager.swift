//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()
    
    private override init() {
        guard let path = Bundle.main.path(forResource: "Jeopardy-theme-song.mp3", ofType: nil)
            else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Audio Error: \(error)")
        }
    }

    private var player: AVAudioPlayer?

    var isSoundEnabled: Bool? {
        get {
            // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
            // You might want to use `object`, because if an object has not been set yet it will be nil
            // Then if it's nil you know it's the user's first time launching the app
            UserDefaults.standard.object(forKey: "sound") as? Bool
        }
    }

    func playSound() {
        player?.play()
    }
    func stopSound() {
        player?.stop()
    }

    func toggleSoundPreference() {
        guard let obj = UserDefaults.standard.object(forKey: "sound"), let enabled = obj as? Bool
        else {
            UserDefaults.standard.set(true, forKey: "sound")
            return
        }
        UserDefaults.standard.set(!enabled, forKey: "sound")
    }

}
