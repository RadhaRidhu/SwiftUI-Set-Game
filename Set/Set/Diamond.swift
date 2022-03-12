//
//  Diamond.swift
//  Set
//
//  Created by Radha Natesan on 2/28/22.
//

import SwiftUI

struct Diamond:Shape{
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX,y: rect.midY)
        var p = Path()
        let right = CGPoint(x:center.x,y:center.y+rect.width/4)
        let left = CGPoint(x:center.x,y:center.y-rect.width/4)
        let top = CGPoint(x:center.x-rect.height,y:center.y)
        let bottom = CGPoint(x:center.x+rect.height,y:center.y)
        p.move(to: right)
        p.addLine(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        return p
    }
  
}
