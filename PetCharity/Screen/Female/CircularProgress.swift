//
//  CircularProgress.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/12.
//

import SwiftUI


struct CircularProgress: View {
    let thickness: CGFloat = 10
    let width: CGFloat = 100
    private let startAngle = -90.0
    private let colors = [
        Color.init(red: 127 / 255.0, green: 127 / 255.0, blue: 213 / 255.0),
        Color.init(red: 134 / 255.0, green: 168 / 255.0, blue: 231 / 255.0),
        Color.init(red: 145 / 255.0, green: 234 / 255.0, blue: 228 / 255.0)
    ]
    
    var progress: Double = 0.80
    
    var body: some View {
        
        ZStack {
            // 背景
            Circle()
                .stroke(Color(.systemGray6), lineWidth: thickness)
            
            // 进度
            RingShape(progress: progress, thickness: thickness)
                .fill(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(360 * 0.3 + startAngle))
                )
        }
        .frame(width: width, height: width, alignment: .center)
        .animation(Animation.easeInOut(duration: 1.0),value: progress)
    }
    
    struct RingShape: Shape {
        
        var progress: Double = 0.0
        let thickness: CGFloat
        let startAngle: Double = -90.0
        
        var animatableData: Double {
            get { progress }
            set { progress = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            
            var path = Path()
            
            path.addArc(
                center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0),
                radius: min(rect.width, rect.height) / 2.0,
                startAngle: .degrees(startAngle),
                endAngle: .degrees(360 * progress + startAngle),
                clockwise: false
            )
            
            return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
        }
    }
}


struct CircularProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress()
    }
}
