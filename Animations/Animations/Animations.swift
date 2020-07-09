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

//Let's do this from First Principles (kinda)

//I want to be able to make shapes using math and SwiftUI animations.
//This was similar to what I did in Calc II & III. So I will start from
//the basics of Calc II and work my way up.

//The difficult thing here is that I have to apply this formula to the path
//of my shape to follow & seemingly fill in.

//But the formulas I am finding are for the volume & surface area. I'm going to see what the author of the Advanced stuff had.

struct TorusView: View {
    @State var buttonScale: Int
    
    var body: some View {
        TorusShape(sides: 4, scale: Double(buttonScale))
    }
}

struct TorusShape: Shape {
    var sides: Int
    private var sidesAsDouble: Double
    var scale: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(sidesAsDouble, scale) }
        set {
            sidesAsDouble = newValue.first
            scale = newValue.second
        }
    }
    
    //done to hide the fact that we are using a double even though sides cannot be a decimal
    init(sides: Int, scale: Double){
        self.sides = sides
        self.sidesAsDouble = Double(sides)
        self.scale = scale
    }
    
    func path(in rect: CGRect) -> Path {
            
            // hypotenuse
            let h = Double(min(rect.size.width, rect.size.height)) / 2.0
            
            // center
            let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
            
            var path = Path()
                    
            let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0

            for i in 0..<Int(sides) + extra {
                let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180

                // Calculate vertex
                let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
                
                if i == 0 {
                    path.move(to: pt) // move to first vertex
                } else {
                    path.addLine(to: pt) // draw line to next vertex
                }
            }
            
            path.closeSubpath()
            
            return path
        }
}

struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        TorusView(buttonScale: 3)
    }
}
