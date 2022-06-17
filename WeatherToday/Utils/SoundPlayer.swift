//
//  SoundPlayer.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 17.06.2022.
//

import AVFoundation
import Foundation

class SoundPlayer {
    static let shared = SoundPlayer()

    var player: AVAudioPlayer?

    private init() {
        // Intentionally unimplemented
    }

    func playSound(with name: String, extensionString: String = "caf") {
        guard let url = Bundle.main.url(forResource: name, withExtension: extensionString) else { return }
        do {
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient,
                                                                mode: AVAudioSession.Mode.default)
                try AVAudioSession.sharedInstance().setActive(true)
            }

            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.play()
        } catch {
            print("SoundPlayer- playSound failed: \(error)")
        }
    }
}
