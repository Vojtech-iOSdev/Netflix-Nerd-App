//
//  ConfettiView.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 13.04.2023.
//

import SwiftUI

struct ConfettiView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        // CONFETTI LAYER
        let confettiLayer = CAEmitterLayer()
        
        confettiLayer.emitterShape = .line
        confettiLayer.emitterCells = createConfettiCells()
        
        // size and position
        confettiLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        confettiLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(confettiLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createConfettiCells() -> [CAEmitterCell] {
        
        // create multiple shaped confettis
        
        var confettiCells: [CAEmitterCell] = []
        
        for index in 1...12 {
            
            let cell = CAEmitterCell()
            
            // import particle images
            cell.contents = UIImage(named: getImage(index: index))?.cgImage
            cell.color = getColor().cgColor
            // new particle creation
            cell.birthRate = 4.5
            // particle existence
            cell.lifetime = 20
            // velocity
            cell.velocity = 120
            // scale
            cell.scale = 0.2
            cell.scaleRange = 0.3
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            
            // acceleration
            cell.yAcceleration = 40
            
            confettiCells.append(cell)
        }
        
        
        return confettiCells
        
    }
    
    func getColor() -> UIColor {
        let colors: [UIColor] = [.systemPink, .systemGreen, .systemBlue, .systemRed, .systemOrange, .systemPurple]
        
        return colors.randomElement()!
    }
    
    func getImage(index: Int) -> String {
        if index < 4 {
            return "rectangle-48"
        }
        else if index > 5 && index <= 8 {
            return "circle-48"
        }
        else {
            return "triangle-48"
        }
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
}
