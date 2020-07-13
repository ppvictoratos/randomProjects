//
//  ContentView.swift
//  iOSAnimations
//
//  Created by Peter Victoratos on 7/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
        VStack {
            Text("Haha Russia Bro").padding()
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white, Color.red]), startPoint: .top, endPoint: .bottom)
        }
            Image("bear")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        
        //make some files for the library
    }
}

//struct Bear: Shape {
//    func path(in rect: CGRect) -> Path {
//        <#code#>
//    }
//
//    //circle over an elipse
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

