//
//  Line.swift
//  Stock
//
//  Created by Андрей Парчуков on 28.03.2021.
//

import SwiftUI

struct Line: View {
    
    // MARK: - Variables
    
    var data: ChartData
    @Binding var frame: CGRect
    @State var touchLocation: CGPoint = .zero
    @State var showIndicator: Bool = false
    @State var currentDataNumber: (Int64, Double) = (0, 0.0)
    var gradientToFill = LinearGradient(gradient: Gradient(colors: [Color.init(hexString: "#DCDCDC"), .white]), startPoint: .bottom, endPoint: .top)
    var index: Int = 0
    let padding: CGFloat = 30
    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        var min: Double?
        var max: Double?
        let points = self.data.onlyPoints()
        if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        } else {
            return 0
        }
        if let min = min, let max = max, min != max {
            if (min <= 0){
                return (frame.size.height - padding) / CGFloat(max - min)
            } else {
                return (frame.size.height - padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    var path: Path {
        let points = self.data.onlyPoints()
        return Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: nil)
    }
    var closedPath: Path {
        let points = self.data.onlyPoints()
        return Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: nil)
    }
    
    // MARK: - Body
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                
                self.closedPath
                    .fill(gradientToFill)
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .transition(.opacity)
                    .animation(.easeIn(duration: 1.6))
                
                self.path
                    .stroke(Color.black,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
                
                if(self.showIndicator) {
                    IndicatorDot()
                        .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
 
                    Baloon(date: currentDataNumber.0, price: currentDataNumber.1)
                        .position(self.getHintPositiion(touchLocation: self.touchLocation))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.touchLocation = CGPoint(x: max(value.location.x, 0), y: 32)
                        self.showIndicator = true
                        self.currentDataNumber = self.getClosestDataPoint(toPoint: self.touchLocation, width: geo.frame(in: .local).size.width-30, height: 240)
                        
                    })
                    .onEnded({ value in
                        self.showIndicator = false
                    })
            )
        }
        
    }
    
    // MARK: - Functions
    
    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
        let closest = self.path.point(to: touchLocation.x)
        return closest
    }
    
    func getHintPositiion(touchLocation: CGPoint) -> CGPoint {
        var closest = getClosestPointOnPath(touchLocation: touchLocation)
        closest.y += 50
        return closest
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> (Int64, Double) {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count){
            return self.data.points[index]
        } else {
            return (0, 0.0)
        }
    }
    
}

// MARK: - Preview

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Line(data: ChartData(values: [StockTimePrice(time: 525442, price: 23.12), StockTimePrice(time: 445356432, price: 50)]),
                 frame: .constant(geometry.frame(in: .local)))
        }
        .frame(width: 350, height: 230)
    }
}
