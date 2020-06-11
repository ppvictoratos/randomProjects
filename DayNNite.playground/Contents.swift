import SwiftUI
import PlaygroundSupport

//have state be more of global thing

let twoEyes = Path { p in
    p.move(to: CGPoint(x:0, y:0))
//    p.addQuadCurve(to: CGPoint(x: 0, y: 50), control: CGPoint(x: 0, y: 0))
    p.addCurve(to: CGPoint(x:50, y:150),
               control1: CGPoint(x: 0, y: 100),
               control2: CGPoint(x: 50, y: 100))
//    p.addQuadCurve(to: CGPoint(x: 0, y: 50), control: CGPoint(x: 0, y: 0))
}

twoEyes.boundingRect

let twoEyesScaled: Path = twoEyes.applying(CGAffineTransform(scaleX: 2, y: 2))

twoEyesScaled.boundingRect

struct Eyes: Shape {
    func path(in rect: CGRect) -> Path {
        let bounds = twoEyes.boundingRect
        let scaleX = rect.size.width/bounds.size.width
        let scaleY = rect.size.width/bounds.size.width
        
        return twoEyes.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
    }
}

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
                twoEyes
                twoEyes
            }
            
            HStack(spacing: 3){
                Circle().scaleEffect(0.25)
                Circle().scaleEffect(0.25)
            }
            
            VStack {
                Smile(startAngle: .degrees(150), endAngle: .degrees(30), clockwise: true).stroke(Color.black, lineWidth: 10)
                .frame(width: 300, height: 300)
                    .rotationEffect(isHappy ? .zero : .degrees(180))
                    .rotation3DEffect(isHappy ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                    .animation(.spring())
            }

        }
    }
}

PlaygroundPage.current.setLiveView(FaceView(isHappy: true))


struct CircleView: View {
    @State private var tapped : Bool = false

    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(tapped ? .yellow : .green)
                    .onTapGesture {self.tapped.toggle()}
                
                Circle().foregroundColor(tapped ? .purple : .red)
                    .onTapGesture {self.tapped.toggle()}
                //TODO: either embed or format faceview to be in this circle
                FaceView(isHappy: tapped)
            }
    }
}

PlaygroundPage.current.setLiveView(CircleView())
