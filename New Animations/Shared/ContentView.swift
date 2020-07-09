//
//  ContentView.swift
//  Shared
//
//  Created by Peter Victoratos on 7/8/20.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animation
    @State private var isZoomed = false
    
    var frame: CGFloat {
        isZoomed ? 300 : 44
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(width: frame, height: frame)
                        .padding(.top, isZoomed ? 20 : 0)
                    
                    if (isZoomed == false) {
                        Text("Taylor Swift - 1989")
                            .font(.headline)
                            .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                        
                        Spacer()
                    }
                }
                
                if isZoomed == true {
                    Text("Taylor Swift - 1989")
                        .font(.headline)
                        .matchedGeometryEffect(id: "AlbumTitle", in: animation)
                        .padding(.bottom, 60)
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation(.spring()) {
                    self.isZoomed.toggle()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: isZoomed ? 400 : 60)
            .background(Color(white: 0.9))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
