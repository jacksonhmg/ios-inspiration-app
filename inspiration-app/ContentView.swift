//
//  ContentView.swift
//  inspiration-app
//
//  Created by jackson mowatt gok on 22/10/2023.
//

import SwiftUI

struct ContentView: View {
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
