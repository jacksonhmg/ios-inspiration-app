//
//  ContentView.swift
//  inspiration-app
//
//  Created by jackson mowatt gok on 22/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showDoIt = false
        @State private var message: String? = nil
        
        var body: some View {
            VStack(spacing: 20) {
                Button("Inspire me") {
                    // Toggle the message each time the button is pressed
                    showDoIt.toggle()
                    message = showDoIt ? "do it!" : "DO IT!"
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                // Conditionally display the message
                if let messageToShow = message {
                    Text(messageToShow)
                }
            }
            .padding()
        }
}

#Preview {
    ContentView()
}
