//
//  ContentView.swift
//  inspiration-app
//
//  Created by jackson mowatt gok on 22/10/2023.
//

import SwiftUI
import AVFoundation
import Combine


class Config {
    static let shared = Config()
    
    var xiApiKey: String?
    
    private init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            xiApiKey = dict["xi-api-key"] as? String
        }
    }
}



class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?

        // ... (same code as before)
    func playInspirationAudio(quote: String) {
            do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch {
                    print("Setting category to AVAudioSessionCategoryPlayback failed.")
                }
        
        
            let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/W4FK71cS2ISzpdIlRaFe")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // Set headers
            request.addValue("audio/mpeg", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let apiKey = Config.shared.xiApiKey {
                request.addValue(apiKey, forHTTPHeaderField: "xi-api-key")
            } else {
                print("Error: Couldn't retrieve the API key")
            }
            
            // Set data (modify this if you want to use the selected quote as text)
        let dataPayload: [String: Any] = [
            "text": quote,
            "model_id": "eleven_multilingual_v2",
            "voice_settings": [
                "stability": 0.5,
                "similarity_boost": 0.75
            ]
        ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: dataPayload, options: .prettyPrinted)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("Error fetching data:", error ?? "Unknown error")
                    return
                }
                
                do {
                        self.audioPlayer = try AVAudioPlayer(data: data)  // This line was missing.
                        DispatchQueue.main.async {
                            self.audioPlayer?.prepareToPlay()
                            self.audioPlayer?.play()
                        }
                    } catch {
                        print("Error playing audio:", error)
                    }
            }
            
            task.resume()
        }
}







struct ContentView: View {
    private var audioManager = AudioManager()

    
    @State private var quotes = [
    "There is nothing impossible to him who will try.",
    "I am indebted to my father for living, but to my teacher for living well.",
    "I would rather live a short life of glory than a long one of obscurity.",
    "Without Knowledge, Skill cannot be focused. Without Skill, Strength cannot be brought to bear and without Strength, Knowledge may not be applied.",
    "Veni, vidi, vici. (I came, I saw, I conquered.)",
    "Experience is the teacher of all things.",
    "It is easier to find men who will volunteer to die, than to find those who are willing to endure pain with patience.",
    "In war, events of importance are the result of trivial causes.",
    "You are in danger of living a life so comfortable and soft, that you will die without ever realizing your true potential.",
    "The only person who was going to turn my life around was me.",
    "If you can get through doing things that you hate to do, on the other side is greatness.",
    "The human mind is so powerful, it can get you through anything.",
    "Victory belongs to the most persevering.",
    "Courage isn't having the strength to go on - it is going on when you don't have strength.",
    "The battlefield is a scene of constant chaos. The winner will be the one who controls that chaos, both his own and the enemy's.",
    "If you want a thing done well, do it yourself."
]

    @State private var selectedQuote: String? = nil
    
    
    
    
    
    
    
        
    var body: some View {
        VStack(spacing: 20) {
            Button("Inspire me") {
                // Select a random quote from the list
                selectedQuote = quotes.randomElement()
                
                if let selected = selectedQuote {
                    audioManager.playInspirationAudio(quote: selected)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            // Conditionally display the selected quote
            if let quoteToShow = selectedQuote {
                Text(quoteToShow)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

