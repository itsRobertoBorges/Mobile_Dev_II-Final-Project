//
//  ContentView.swift
//  war-challenge
//
//  Created by Roberto on 2023-01-22.
//

import SwiftUI
import AVKit

class AudioPlayer {
    static let shared = AudioPlayer()
    var player: AVPlayer?
    func playSound() {
        let soundURL = Bundle.main.url(forResource: "gameAudioTrimmed", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: soundURL)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}

struct ContentView: View {
    
    @State private var playerCard = "card5"
    @State private var cpuCard = "card12"
    @State private var playerScore = 0
    @State private var cpuScore = 0
    @State private var totalCredits = 0
    @State private var player: AVPlayer?
    var img = "background"
    var img2 = ""
    var img3 = ""


    
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background music
                Image(img).scaledToFill()
                Image("logo")
                    .padding(.top, -325.0)
                    .offset(x:0,y:-40)
                Button(action: {
                    print("Cards dealt")
                    // Sound
                    let soundURL = Bundle.main.url(forResource: "button", withExtension: "mp3")!
                    let playerItem = AVPlayerItem(url: soundURL)
                    player = AVPlayer(playerItem: playerItem)
                    player?.play()
                    
                    let playerRand = Int.random(in: 2...14)
                    let cpuRand = Int.random(in: 2...14)
                    
                    // Update card
                    playerCard = "card" + String(playerRand)
                    cpuCard = "card" + String(cpuRand)
                    print("Cards have changed succesfully")
                    
                    // Update score
                    if(playerCard > cpuCard){
                        playerScore = playerScore + 1
                        print("Player score is now: ", playerScore)
                    } else if(cpuCard > playerCard) {
                        cpuScore = cpuScore + 1
                        print("Cpu score is now: ", cpuScore)
                    }
                    
                    // Condtional statement for winner & score reset
                    if(playerScore >= 10){
                        totalCredits += 25
                        playerScore = 0
                        cpuScore = 0
                    } else if(cpuScore >= 10) {
                        totalCredits -= 25
                        playerScore = 0
                        cpuScore = 0
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
                VStack {
                    Text("Total Credits: \(totalCredits)").foregroundColor(Color.white)
                        .padding(.top, 280)
                    NavigationLink(destination: InfoPage()) {
                        Image(systemName: "questionmark.square.fill")
                            .padding(.top, 100)
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                        NavigationLink(destination: SoundPage()) {
                            Image(systemName: "speaker.wave.3.fill")
                                .padding(.top, 100)
                                .font(.system(size: 25))
                                .foregroundColor(Color.white)
                    }
                }
            }.onAppear(perform: playSound)
        }

    }.navigationBarBackButtonHidden()
        
}
    func playSound() {
        AudioPlayer.shared.playSound()
}

struct InfoPage: View {
    let name = "Roberto Borges"
    let stuId = "101255891"
    let mac = "Macbook Air M2 2022"
    let version = "14.2"
    var body: some View {
        NavigationView {
            ZStack{
                Image("background").scaledToFill()
                Text("Info Page")
                    .padding(.bottom, 600)
                    .font(.system(size: 50))
                    .foregroundColor(Color.white)
                HStack {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "arrowshape.turn.up.backward")
                            .padding(.top, 600)
                            .padding(.leading, 30)
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                    }
                   // Spacer() // added spacer here
                    VStack {
                        Text(" ")
                        Text("Student: " + name + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                        Text("Student ID: " + stuId + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                        Text(" Built on: " + mac + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                        Text("Xcode version: " + version)
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                        Text(" ")
                    }.background(Color.gray)
                        .cornerRadius(15)
                        .padding(.bottom, 60)
                        .padding(.horizontal, -60)
                    Spacer()
                }
            }
        }.navigationBarBackButtonHidden()
    }
}
    struct SoundPage: View {
        var body: some View{
            NavigationView{
                ZStack{
                    Image("background").scaledToFill()
                    Text("Sound")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                        .padding(.top, -300)
                    Button {
                        print("sound off")
                    } label: {
                        Text("Sound Off")
                            .foregroundColor(Color.white)
                    }

                }
            }.navigationBarBackButtonHidden()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
