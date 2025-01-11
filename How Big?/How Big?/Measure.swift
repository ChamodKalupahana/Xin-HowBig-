//
//  Measure.swift
//  How Big?
//
//  Created by User on 27/12/2024.
//

import SwiftUI

struct Measure: View {
    @StateObject var coordinator = Coordinator.shared
    
    @State var isShowingReferenceScreen : Bool = false
    var body: some View {
        NavigationStack{
            ZStack(alignment : .bottom){
                ARController()
                
                howBigFunShapeButton
            }
            .navigationTitle("Xin's How Big?")
            
            .sheet(isPresented: $isShowingReferenceScreen) {
                ReferencesScreen()
                    .environmentObject(coordinator)
            }
        }
    }
    
    var calculateButton : some View {
        ZStack{
            if coordinator.selectedDistance != nil {
                Button {
                    isShowingReferenceScreen = true
                } label: {
                    HStack{
                        Image(systemName: "function")
                        Text("How Big?")
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 7.5))
                    .padding()
                    
                }
            }
        }
    }
    
    var howBigFunShapeButton : some View {
        ZStack{
            if coordinator.selectedDistance != nil {
                Button {
                    isShowingReferenceScreen = true
                } label: {
                    HStack{
                        Image(systemName: "carrot.fill")
                        Text("How Big?")
                    }
                    .foregroundStyle(Color.white)
                    .padding()
//                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedStar(cornerRadius: 5.0))
                    .padding()
                    .background(Color.red.brightness(0.7))
                    
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


// Five-point star with rounded tips
struct RoundedStar: Shape {
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { return cornerRadius }
        set { cornerRadius = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let r = rect.width / 2
        let rc = cornerRadius
        let rn = r * 0.95 - rc
        
        // start angle at -18 degrees so that it points up
        var cangle = -18.0
        
        for i in 1 ... 5 {
            // compute center point of tip arc
            let cc = CGPoint(x: center.x + rn * CGFloat(cos(Angle(degrees: cangle).radians)), y: center.y + rn * CGFloat(sin(Angle(degrees: cangle).radians)))

            // compute tangent point along tip arc
            let p = CGPoint(x: cc.x + rc * CGFloat(cos(Angle(degrees: cangle - 72).radians)), y: cc.y + rc * CGFloat(sin(Angle(degrees: (cangle - 72)).radians)))

            if i == 1 {
                path.move(to: p)
            } else {
                path.addLine(to: p)
            }

            // add 144 degree arc to draw the corner
            path.addArc(center: cc, radius: rc, startAngle: Angle(degrees: cangle - 72), endAngle: Angle(degrees: cangle + 72), clockwise: false)

            // Move 144 degrees to the next point in the star
            cangle += 144
        }

        return path
    }
}
