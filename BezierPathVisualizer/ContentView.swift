//
//  ContentView.swift
//  BezierPathVisualizer
//
//  Created by Dhanajit Kapali on 19/12/22.
//

import SwiftUI
import PureSwiftUI

private let heartLayoutConfig = LayoutGuideConfig.grid(columns: 8, rows: 10)

struct ContentView: View {
    var screenWidth  = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    @State var shouldShowControlPoints = false
    var body: some View {
        VStack(alignment: .center) {
            Button {
                shouldShowControlPoints.toggle()
            } label: {
                Toggle("", isOn: $shouldShowControlPoints)
                    .frame(width: 100)
            }
            ZStack {
                MyCustomShape(showControlPoints: $shouldShowControlPoints)
                    .stroke(Color.black, lineWidth: 2)
                    .layoutGuide(heartLayoutConfig)
                    .frame(width: screenWidth/1.2, height: screenWidth/1.2)
            }
        }
    }
}

struct MyCustomShape: Shape {
    @Binding var showControlPoints : Bool
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        return Path { path in
            path.move(to: CGPoint(
                x: rect.minX,
                y: rect.minY+(height*0.1))
            )
            
            path.curve(
                CGPoint(
                    x: rect.midX,
                    y: rect.minY+(height*0.30)
                ),
                cp1: CGPoint(
                    x: rect.minX + (width*0.3),
                    y: rect.minY + (height*0.1)
                ),
                cp2: CGPoint(
                    x: rect.minX + (width*0.2),
                    y: rect.minY + (height*0.30)
                ),
                showControlPoints: showControlPoints
            )
            path.curve(
                CGPoint(
                    x: rect.maxX,
                    y: rect.minY+(height*0.1)
                ),
                cp1: CGPoint(
                    x: rect.maxX - (width*0.2),
                    y: rect.minY+(height*0.30)
                ),
                cp2: CGPoint(
                    x: rect.maxX - (width*0.3),
                    y: rect.minY + (height*0.1)
                ),
                showControlPoints: showControlPoints
            )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .showLayoutGuides(true)
    }
}
