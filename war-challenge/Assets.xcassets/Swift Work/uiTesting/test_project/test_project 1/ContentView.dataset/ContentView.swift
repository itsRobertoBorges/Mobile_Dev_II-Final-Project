//
//  ContentView.swift
//  test_project
//
//  Created by Roberto on 2023-01-22.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack {
            Button("Click me", action: {
                print("Hello world")
            })
            // Button instance with trailing closure
            Button("Click me") {
                print("Hello World")
            }
            // Button instance with label view
            
            Button(action: {
                
            }, label: {
                
                
                
                    HStack {
                        Image(systemName: "pencil.circle.fill")
                        Text("Edit")
                    }
                })
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
