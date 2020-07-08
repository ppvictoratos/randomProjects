//
//  Animations.swift
//  Animations
//
//  Created by Peter Victoratos on 7/7/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

struct Animations1: View {
    @State private var half = false
    @State private var dim = false
    
    var body: some View {
        Image("orange")
            .scaleEffect(half ? 0.5 : 1.0)
            .opacity(dim ? 0.2 : 1.0)
            .animation(.easeInOut(duration: 1.0))
            .onTapGesture {
                self.dim.toggle()
                self.half.toggle()
        }
    }
}

struct Animations2: View {
    @State private var half = false
    @State private var dim = false
    
    var body: some View {
        Image("orange")
            .scaleEffect(half ? 0.5 : 1.0)
            .opacity(dim ? 0.5 : 1.0)
            .onTapGesture {
                self.half.toggle()
                
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.dim.toggle()
                }
        }
    }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        Animations1()
        Animations2()
        }
    }
}
