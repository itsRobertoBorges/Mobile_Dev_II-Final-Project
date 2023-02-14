//
//  ContentView.swift
//  war-challenge
//
//  Created by Roberto on 2023-01-22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var playerCard = "card5"
    @State private var cpuCard = "card12"
    @State private var playerScore = 0
    @State private var cpuScore = 0
    
    var body: some View {
        
        ZStack {
            Image("background").scaledToFill()
            Image("logo")
                .padding(.top, -325.0)
                .offset(x:0,y:-40)
            Button(action: {
                
                let playerRand = Int.random(in: 2...14)
                let cpuRand = Int.random(in: 2...14)
                
                // Card sound
                let audioPlayer = AVPlayer(url:
                    URL(fileURLWithPath: "path/to/audio.mp3"))
                
                // Update card
                playerCard = "card" + String(playerRand)
                cpuCard = "card" + String(cpuRand)
                
                // Update score
                if(playerCard > cpuCard){
                    playerScore = playerScore + 1
                } else if(cpuCard > playerCard) {
                    cpuScore = cpuScore + 1
                }
                
                
            }, label: {
                Image("dealbutton")
            })
                .padding(.top, 500)
            HStack {
                Image(playerCard)
                    .padding(.horizontal, 50)
                    .padding(.top, -100)
                Image(cpuCard)
                    .padding(.top, -100.0)
                    .padding(.horizontal, 50.0)
            }
            
            VStack {
                Text("Player")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, -100)
                    .padding(.horizontal, 50)
                Text(String(playerScore))
                    .font(.headline)
                    .padding(.top, -90)
                    .foregroundColor(Color.white)
            }
            Spacer()
            VStack {
                Text("CPU")
                    .font(.headline)
                    .foregroundColor(Color.white)
                Text(String(cpuScore))
                    .foregroundColor(Color.white)
            }
            
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
