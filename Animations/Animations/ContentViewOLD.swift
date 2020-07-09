//
//  ContentView.swift
//  Animations
//
//  Created by Peter Victoratos on 7/7/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

//ahhh! i forget how to make the preview simulator react to touch..

struct ContentViewOLD: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentViewOLD_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct RootView: View {
    @State private var vector: AnimatableVector = .zero

    var body: some View {
        VStack{
        Animations1()
        LineChart(vector: vector)
            .stroke(Color.red)
            .animation(Animation.default.repeatForever())
            .onAppear {
                self.vector = AnimatableVector(values: [50, 100, 75, 100])
            }
        }
    }
}

struct LineChart: Shape {
    var vector: AnimatableVector

    var animatableData: AnimatableVector {
        get { vector }
        set { vector = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            let xStep = rect.width / CGFloat(vector.values.count)
            var currentX: CGFloat = xStep
            path.move(to: .zero)

            vector.values.forEach {
                path.addLine(to: CGPoint(x: currentX, y: CGFloat($0)))
                currentX += xStep
            }
        }
    }
}
