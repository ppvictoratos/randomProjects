import SwiftUI
import PlaygroundSupport

//what are the add-on's you get with using a shape type rather than a view?

//is there any way to calculate this faster? maybe using computed variables for the CGPoint
//locations?

struct House: View {
    var body: some View {
        ZStack{
            ZStack{
                //house body
                Path { path in
                    path.move(to: CGPoint(x: 70, y: 420))
                    path.addLine(to: CGPoint(x: 70, y: 600))
                    path.addLine(to: CGPoint(x: 300, y: 600))
                    path.addLine(to: CGPoint(x: 300, y: 420))
                }.fill(Color.blue)
                //door
                Path { path in
                    path.move(to: CGPoint(x: 168, y: 600))
                    path.addLine(to: CGPoint(x: 168, y: 530))
                    path.addLine(to: CGPoint(x: 206, y: 530))
                    path.addLine(to: CGPoint(x: 206, y: 600))
                }.fill(Color.black)
            }
            
            ZStack {
                //chimney
                Path { path in
                    path.move(to: CGPoint(x: 250, y: 420))
                    path.addLine(to: CGPoint(x: 250, y: 330))
                    path.addLine(to: CGPoint(x: 280, y: 330))
                    path.addLine(to: CGPoint(x: 280, y: 420))
                }.fill(Color.black)
                //roof
                Path { path in
                    path.move(to: CGPoint(x: 55, y: 420))
                    path.addLine(to: CGPoint(x: 175, y: 300))
                    path.addLine(to: CGPoint(x: 315, y: 420))
                }.fill(Color.red)
            }
        }
    }
}

PlaygroundPage.current.setLiveView(House())

struct Hat: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        //A 1/4 maxX, 3/4 maxY
        path.move(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4) + 35))
        path.addLine(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4) + 35))
        
        //B 1/4 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (3/4) + 20))
        
        //C 3/8 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (3/8), y: rect.maxY * (3/4) + 20))
        
        //D 3/8 maxX, 3/4 maxY + 40
        path.addLine(to: CGPoint(x: rect.maxX * (3/8), y: rect.maxY * (3/4) - 40))
        
        //E 5/8 maxX, 3/4 maxY + 40
        path.addLine(to: CGPoint(x: rect.maxX * (5/8), y: rect.maxY * (3/4) - 40))
        
        //F 5/8 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (5/8), y: rect.maxY * (3/4) + 20))
        
        //G 3/4 maxX, 3/4 maxY + 15
        path.addLine(to: CGPoint(x: rect.maxX * (3/4), y: rect.maxY * (3/4) + 20))
        
        //H 3/4 maxX, 3/4 maxY
        path.addLine(to: CGPoint(x: rect.maxX * (3/4), y: rect.maxY * (3/4) + 35))

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

//Background should keep its primary color (purple or orange) but should consist of rows
//of a sine wave from top to bottom, light to dark tint
struct Waves: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX / 8 , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX / 8 + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX / 8 + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX / 8, y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (1/4) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (1/4) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (1/4) + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX * (1/4), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (3/8) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (3/8) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (3/8) + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX * (3/8), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (1/2) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (1/2) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (1/2) + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX * (1/2), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (5/8) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (5/8) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (5/8) + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX * (5/8), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (3/4) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (3/4) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (3/4) + 10, y: rect.maxY * (1/4)))

        path.move(to: CGPoint(x: rect.maxX * (3/4), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX * (7/8) , y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX * (7/8) + 10, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX * (7/8) + 10, y: rect.maxY * (1/4)))
        
        path.move(to: CGPoint(x: rect.maxX * (7/8), y: rect.maxY * (1/4)))
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY * (1/4)),
                      control1: CGPoint(x: rect.maxX, y: rect.maxY * (1/4) - 20),
                      control2: CGPoint(x: rect.maxX, y: rect.maxY * (1/4)))
        return path
    }
}

PlaygroundPage.current.setLiveView(Waves())

struct ViewWaves: View{
    var body: some View {
        Path { path in
            
        }
    }
}

struct ComputedWaves: Shape {
    //so unlike drawing in OO, this origin starts from the bottom right?
    
    func path(in rect: CGRect) -> Path {
        let startPoint: CGPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        var midPoint: CGPoint = CGPoint(x: rect.midX, y:rect.midY)
        
        var path = Path()
        path.move(to: startPoint)
        path.addLine(to: midPoint)
        midPoint.y += 5
        path.addLine(to: midPoint)
        path.foregroundColor(.red)
        midPoint.y += 5
        path.addLine(to: midPoint)
        return path
    }
}

PlaygroundPage.current.setLiveView(ComputedWaves())

struct PictureView: View {
    @State private var tapped : Bool = false

    var body: some View {
            ZStack{
                Rectangle()
                    .foregroundColor(tapped ? .orange : .purple)
                    .onTapGesture {self.tapped.toggle()}
                Waves()
                Circle().foregroundColor(tapped ? .blue : .yellow)
                    .onTapGesture {self.tapped.toggle()}
                FaceView(isHappy: tapped)
            }
    }
}

PlaygroundPage.current.setLiveView(PictureView())
