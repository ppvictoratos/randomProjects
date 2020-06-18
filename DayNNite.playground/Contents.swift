import SwiftUI
import PlaygroundSupport

//have state be more of global thing
//use computed, generic properties to create custom sized shapes such as circles

struct Hat: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //TODO:- turn hat upside down
        
        //A 1/4 maxX, 3/4 maxY
        path.move(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4)))
        path.addLine(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4)))
        
        //B 1/4 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4) - 15))
        
        //C 3/8 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (3/8), y: rect.maxY * (3/4) - 15))
        
        //D 3/8 maxX, 3/4 maxY + 40
        path.addLine(to: CGPoint(x: rect.maxX * (3/8), y: rect.maxY * (3/4) - 40))
        
        //E 5/8 maxX, 3/4 maxY + 40
        path.addLine(to: CGPoint(x: rect.maxX * (5/8), y: rect.maxY * (3/4) - 40))
        
        //F 5/8 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (5/8), y: rect.maxY * (3/4) - 15))
        
        //G 3/4 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (3/4), y: rect.maxY * (3/4) - 15))
        
        //H 3/4 maxX, 3/4 maxY
        path.addLine(to: CGPoint(x: rect.maxX * (3/4), y: rect.maxY * (3/4)))

        return path
    }
}

PlaygroundPage.current.setLiveView(Hat())

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
            VStack {
                Hat().fill(isHappy ? Color.clear : Color.black)
                
                HStack(spacing: 3){
                    Circle().scaleEffect(0.25)
                    Circle().scaleEffect(0.25)
                }
                Smile(startAngle: .degrees(150),
                      endAngle: .degrees(30),
                      clockwise: true)
                    .stroke(Color.black, lineWidth: 10)
                    .frame(width: 300, height: 300)
//                    .rotationEffect(isHappy ? .zero : .degrees(180))
                    .rotation3DEffect(isHappy ? .degrees(180) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                    .transformEffect(isHappy ? CGAffineTransform(translationX: 0, y: 0) : CGAffineTransform(translationX: 0, y: -180))
            }
    }
}

PlaygroundPage.current.setLiveView(FaceView(isHappy: true))

//TODO:- Customize background to utilize some funky shapes

struct PictureView: View {
    @State private var tapped : Bool = false

    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(tapped ? .orange : .purple)
                    .onTapGesture {self.tapped.toggle()}
                
                Circle().foregroundColor(tapped ? .blue : .yellow)
                    .onTapGesture {self.tapped.toggle()}
                //TODO: either embed or format faceview to be in this circle
                FaceView(isHappy: tapped)
            }
    }
}

PlaygroundPage.current.setLiveView(PictureView())
