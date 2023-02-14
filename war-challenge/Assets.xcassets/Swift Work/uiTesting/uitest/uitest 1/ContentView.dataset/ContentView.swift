//
//  ContentView.swift
//  uitest
//
//  Created by Roberto on 2023-01-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack(){
            Image("logo").resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
        HStack{
                Text("What is it good for?")
                Text("Nothing..")
                    .padding()
            
            }
           
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
