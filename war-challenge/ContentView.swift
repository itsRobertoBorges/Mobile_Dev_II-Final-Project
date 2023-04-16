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
    var gamePlayer: AVPlayer?
    var casinoPlayer: AVPlayer?
    var isMuted = false
    
    func playGameSound() {
        let gameSoundURL = Bundle.main.url(forResource: "gameAudioTrimmed", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: gameSoundURL)
        if gamePlayer == nil {
            gamePlayer = AVPlayer(playerItem: playerItem)
        } else {
            gamePlayer?.replaceCurrentItem(with: playerItem)
        }
        gamePlayer?.volume = isMuted ? 0.0 : 1.0
        gamePlayer?.play()
    }
    
    func stopGameSound(){
        gamePlayer?.pause()
    }
    
    func playCasinoMusic() {
        let casinoSoundURL = Bundle.main.url(forResource: "casinoMusic", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: casinoSoundURL)
        if casinoPlayer == nil {
            casinoPlayer = AVPlayer(playerItem: playerItem)
        } else {
            casinoPlayer?.replaceCurrentItem(with: playerItem)
        }
        casinoPlayer?.volume = isMuted ? 0.0 : 1.0
        casinoPlayer?.play()
    }
    
    func toggleMute() {
        if let gamePlayer = gamePlayer {
            gamePlayer.isMuted = !gamePlayer.isMuted
            isMuted = gamePlayer.isMuted
        }
        if let casinoPlayer = casinoPlayer {
            casinoPlayer.isMuted = !casinoPlayer.isMuted
            isMuted = casinoPlayer.isMuted
        }
    }
}

struct ContentView: View {
    
    @State private var playerCard = "card5"
    @State private var cpuCard = "card12"
    @State private var playerScore = 0
    @State private var cpuScore = 0
    @State private var totalCredits = 75 {
        //audio change for level 2 (100 credits)
        didSet {
            if totalCredits == 100 {
                AudioPlayer.shared.stopGameSound()
                AudioPlayer.shared.playCasinoMusic()
            }
        }
    }
    @State private var player: AVPlayer?
    @State private var isMuted = false
    //original background
    var img = "background"
    //100+ credits
    var img1 = "darkbluebackground"
    //200+ credits
    var img2 = "blackbackground"
    
    func playSound() {
        AudioPlayer.shared.playGameSound()
    }
    
    func playCasinoSound(){
        AudioPlayer.shared.playCasinoMusic()
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                if totalCredits >= 100 && totalCredits < 200 {
                    Image(img1).scaledToFill()
                } else if totalCredits >= 200 {
                    Image(img2).scaledToFill()
                } else {
                    Image(img).scaledToFill()
                }
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
                Button(action: {
                    AudioPlayer.shared.toggleMute()
                }, label: {
                    Group {
                        if AudioPlayer.shared.isMuted {
                            Image(systemName: "speaker.slash.fill")
                        } else {
                            Image(systemName: "speaker.3.fill")
                        }
                    }
                })
                .padding(.top, 600)
                .padding(.leading, -150)
                .foregroundColor(Color.white)
                .font(.system(size: 30))
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
                        .font(.system(size: 20))
                    NavigationLink(destination: InfoPage()) {
                        Image(systemName: "questionmark.square.fill")
                            .padding(.top, 100)
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                        NavigationLink(destination: manualPage()) {
                            Image(systemName: "book.fill")
                                .padding(.top, 100)
                                .font(.system(size: 30))
                                .foregroundColor(Color.white)
                        }.navigationBarBackButtonHidden(true)
                        
                    }.onAppear(perform: playSound)
                        .onDisappear(perform: {
                            // Stop playing the background music when the view disappears
                            player?.pause()
                        })
                }
            }.navigationBarHidden(true)
        }
    }
    
    
    
    struct InfoPage: View {
        let name = "Roberto Borges"
        let stuId = "101255891"
        let mac = "Macbook Air M2 2022"
        let version = "Version 14.2 (14C18)"
        
        var body: some View {
            NavigationView {
                ZStack{
                    Image("darkgraybackground").scaledToFill()
                    Text("Info Page")
                        .padding(.bottom, 600)
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                    VStack {
                        Text("")
                        Text("Student: " + name + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                        Text("Student ID: " + stuId + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                        Text("Built on: " + mac + "\n")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                        Text("Xcode version: " + version)
                            .foregroundColor(Color.white)
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .shadow(color: .black, radius: 2, x: 0.0, y: 0.0)
                        Text(" ")
                    }
                    .background(Color.gray)
                    .cornerRadius(15)
                    .padding(.bottom, 60)
                    .padding(.horizontal, -60)
                    .shadow(color: .black, radius: 4, x: 0.0, y: 0.0)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct manualPage: View {
    var img = "background"
    
    var body: some View {
        ZStack {
            Image(img)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.9)
                .blur(radius: 5)
                .brightness(-0.15)
                .contrast(1.1)
                .saturation(1.5)
            VStack {
                Text("Instructions")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                VStack(alignment: .leading, spacing: 20) {
                    Text("Draw a card, the highest card value gets a point.")
                    Text("If you get 10 points, you earn 25 credits.")
                    Text("If you lose, you lose 25 credits.")
                }
                .multilineTextAlignment(.center)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.black)
                        .opacity(0.7)
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 100)
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
    }
}

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
}
