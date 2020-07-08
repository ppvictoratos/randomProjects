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

struct Line2: Shape {
    var x: CGFloat
    var y: CGFloat

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(x, y) }
        set {
            x = newValue.first
            y = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: x, y: y))
        }
    }
}

PlaygroundPage.current.setLiveView(RootView())
