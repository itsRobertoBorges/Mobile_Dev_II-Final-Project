//
//  ContentView.swift
//  Xcode Tutorial Demo
//
//  Created by Roberto on 2023-01-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("pinkFlower")
                .resizable()
                .cornerRadius(400)
                .imageScale(.small)
                .foregroundColor(.green)
                .frame(width: 400.0, height: 400.0)
        
            Text("Look, it's a flower..")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
