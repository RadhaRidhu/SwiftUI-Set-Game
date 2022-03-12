//
//  SetGameViewModel.swift
//  Set
//
//  Created by Radha Natesan on 2/28/22.
//

import Foundation
import SwiftUI

class SetGameViewModel : ObservableObject {
    typealias Card = SetGame.Card
    
    @Published private var model = SetGame()
    
    init(){
        model.startGame()
    }
    var cards:Array<SetGame.Card> {
        return model.cards
    }
    var cardsMatched:Array<SetGame.Card> {
        return model.cardsMatched
    }
    var cardsDealt:Array<SetGame.Card> {
        return model.cardsDealt
    }
    
    //MARK: Intents
    
    func dealMore (){
        model.dealMore()
    }
    func selectCard(card:Card){
        model.addCardSelection(card: card)
    }
    func getColor(card:Card)-> Color{
        switch card.color{
            case .Red: return Color.red
            case .Green: return Color.green
            case .Purple:return Color.purple
        }
    }
    func getShading(card:Card)-> Double{
        switch card.shading{
            case .Open: return 0.0
            case .Solid: return 1.0
        case .Stripe:return 0.5
        }
    }
    func getCardBGColor(card:Card)->Color{
        if card.isSelected{
            return .yellow
        }else{
            return .white
        }
    }
    func getNumberOfSymbols(card:Card)->Int{
        return card.numberOfShapes
    }
 
}
