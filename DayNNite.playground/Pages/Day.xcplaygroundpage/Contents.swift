//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import SwiftUI

struct RootView: View {
    @State private var coordinate: CGFloat = 0

    var body: some View {
        VStack{
            Line1(coordinate: coordinate)
                .stroke(Color.red)
                .animation(Animation.linear(duration: 1).repeatForever())
                .onAppear { self.coordinate = 100 }
            Line1Animatable(coordinate: coordinate)
                .stroke(Color.red)
                .animation(Animation.linear(duration: 1).repeatForever())
                .onAppear { self.coordinate = 100 }
            Watermelon()
                .stroke(Color.green)
            PolygonShape(sides: 3).stroke(Color.purple, lineWidth: 2)
        }.frame(width: 300, height: 300, alignment: .center)

    }
}


struct Line1: Shape {
    let coordinate: CGFloat

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: coordinate, y: coordinate))
        }
    }
}

struct Line1Animatable: Shape {
    var coordinate: CGFloat

    var animatableData: CGFloat {
        get { coordinate }
        set { coordinate = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: coordinate, y: coordinate))
        }
    }
}

struct Watermelon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addEllipse(in: rect)
        }
    }
    
}

struct PolygonShape: Shape {
    var sides: Int
    
    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        
        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        var path = Path()
                
        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180

            // Calculate vertex position
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


PlaygroundPage.current.setLiveView(RootView())

