import SwiftUI
import PlaygroundSupport

//have state be more of global thing 

struct Smile: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
}

struct FaceView: View {
    var isHappy: Bool
    
    var body: some View {
        VStack{
            HStack{
                Circle().foregroundColor(.black).scaleEffect(0.1)
                Circle().foregroundColor(.black).scaleEffect(0.1)
            }
            //TODO: fix the spacing between these two
            Smile(startAngle: .degrees(180), endAngle: .zero, clockwise: true).stroke(Color.black, lineWidth: 10)
            .frame(width: 300, height: 300)
                .rotationEffect(isHappy ? .zero : .degrees(180))
                .rotation3DEffect(isHappy ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(0.5)
            .animation(.spring())
        }
    }
}

PlaygroundPage.current.setLiveView(FaceView(isHappy: true))


struct CircleView: View {
    @State private var tapped : Bool = false

    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .onTapGesture {self.tapped.toggle()}
                
                Circle().foregroundColor(tapped ? .yellow : .blue)
                    .onTapGesture {self.tapped.toggle()}
                //TODO: either embed or format faceview to be in this circle
                FaceView(isHappy: tapped)
            }
    }
}

PlaygroundPage.current.setLiveView(CircleView())
