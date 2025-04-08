//
//  MusicCentre.swift
//  Seminole
//
//  Created by Pavel Ivanov on 17.03.2025.
//

import AVFoundation

class MusicCentre: ObservableObject {
    static let shared = MusicCentre()
    private var audioPlayer: AVAudioPlayer?

    @Published var isSoundOn: Bool = false {
        didSet {
            if isSoundOn {
                audioPlayer?.volume = 1
            } else {
                audioPlayer?.volume = 0
            }
        }
    }

    private init() {
        // Загружаем музыку из файла
        if let url = Bundle.main.url(forResource: "audio", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
            } catch {
                print("Error loading audio file: \(error.localizedDescription)")
            }
        }
    }

    func playMusic() {
        audioPlayer?.play()
    }

    func stopMusic() {
        audioPlayer?.stop()
    }
}
