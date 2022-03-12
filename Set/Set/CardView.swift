//
//  CardView.swift
//  Set
//
//  Created by Radha Natesan on 3/10/22.
//

import SwiftUI

struct CardView: View{
    let card:SetGameViewModel.Card
    var game:SetGameViewModel
    var body: some View{
        GeometryReader{geometry in
            ZStack{
                
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                shape.fill().foregroundColor(game.getCardBGColor(card:card))
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
                symbol()
                
                
            }.clipped()
    
        }
        
    }
    
    private func symbol() -> some View{

        VStack{
            ForEach(0..<game.getNumberOfSymbols(card: card),id:\.self){i in
                getShape()
                    .aspectRatio(2, contentMode: .fit)
                
            }
        }

            .padding(.horizontal)
            .foregroundColor(game.getColor(card: card))
            
            
    }
    
    @ViewBuilder private func getShape() -> some View{
        switch card.symbol{
        case .Rectangle: Rectangle()
                .opacity(game.getShading(card: card))
                .overlay(Rectangle().stroke(lineWidth: DrawingConstants.symbolStrokeWidth))
        case .Circle: Circle()
                .opacity(game.getShading(card: card))
                .overlay(Circle().stroke(lineWidth: DrawingConstants.symbolStrokeWidth))
        case .Diamond: Diamond()
                .opacity(game.getShading(card: card))
                .overlay(Diamond().stroke(lineWidth: DrawingConstants.symbolStrokeWidth))
        }
        

    }


            

    private struct DrawingConstants{
        static let cornerRadius : CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let symbolStrokeWidth: CGFloat = 2
    }
    
}
