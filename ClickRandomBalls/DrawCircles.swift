//
//  DrawCircles.swift
//  ClickRandomBalls
//
//  Created by Alex Novos on 12/5/16.
//  Copyright © 2016 Alex Novos. All rights reserved.
//

import UIKit
import Darwin
var shapeLayer = CAShapeLayer()
var randomX = 0
var randomY = 0

class DrawCircles: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let circlesCount = 10
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = Int(screenSize.width)
        let screenHeight = Int(screenSize.height)
//        let minRadius = screenWidth*0.025
//        let maxRadius = screenWidth*0.25
//        let diff: CGFloat = maxRadius-minRadius
        
//        for i in 1...circlesCount {

                let myTimer : Timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.myPerformeCode), userInfo: nil, repeats: true)
            
//        }
        

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self) {
            print("x= \(location.x.rounded())  y= \(location.y.rounded())")
            print("ranX = \(randomX) ranY = \(randomY)")
            let x = Int(location.x)
            let y = Int(location.y)
            let diag = getDistanceDIf(x: x, y: y)
            print("diag = \(diag)")
        }
        

    }
    
    func myPerformeCode() {
        
        let randomRadius = arc4random_uniform(64)+20
        //            print(randomRadius)
        randomX = Int(arc4random_uniform(375-randomRadius*2)+randomRadius)
        
        randomY = Int(arc4random_uniform(667-randomRadius*2)+randomRadius)
        
        let randomColor = self.getRandomCGColor()
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: randomX,y: randomY), radius: CGFloat(randomRadius), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        
        //change the fill color
        shapeLayer.fillColor = randomColor
        //you can change the stroke color
        shapeLayer.strokeColor = randomColor
        //you can change the line width
        shapeLayer.lineWidth = 3.0
        
        self.layer.addSublayer(shapeLayer)
        if let subl = self.layer.sublayers {
            if subl.count > 1 {
                self.layer.sublayers?.remove(at: 0)
            }
        }
    }
    
    func getRandomCGColor() -> CGColor {
        let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0).cgColor
    }
    
    func getDistanceDIf(x: Int, y: Int) -> Int {
       
        
        let difX = abs(x-randomX)
        let difY = abs(y-randomY)
        let diag = sqrt(Double(difX*difX + difY*difY))
//        print(diag)
        return(Int(diag.rounded()))
    }
}
