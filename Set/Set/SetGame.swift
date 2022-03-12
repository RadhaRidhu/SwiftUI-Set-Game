//
//  SetGame.swift
//  Set
//
//  Created by Radha Natesan on 2/28/22.
//

import Foundation
import SwiftUI

struct SetGame{
    private(set) var cards:Array<Card>
    private(set) var cardsDealt:Array <Card>
    private(set) var cardsSelected:Array<Card>
    private(set) var cardsMatched:Array<Card>
    private(set) var dealtCount = 0
    
    init(){
        cards = []
        cardsDealt=[]
        cardsSelected = []
        cardsMatched = []
        var id = 0
        for color in Color.allCases {
            for symbol in Symbol.allCases{
                for shading in Shading.allCases{
                    for i in 0..<3{
                        let card = Card(id: id, color: color, symbol: symbol, shading: shading, numberOfShapes: i+1)
                        cards.append(card)
                        id=id+1
                    }
                }
            }
        }
        cards = cards.shuffled()
        
    }
    
    mutating func startGame(){
        dealtCount = 12
        cardsDealt = Array(cards.prefix(upTo: 12))
        print(cardsDealt)
    }
    mutating func dealMore(){
       
        if(dealtCount<cards.count){
            for i in 0..<3{
                cardsDealt.append(cards[dealtCount+i])
            }
            dealtCount = dealtCount + 3
        }
        
    }
    func sameOrDifferent<T:Hashable>(someArray : Array<T>) -> Bool{
        if(someArray.allSatisfy({$0 == someArray[0]})){
            return true
        }
        if(Set(someArray).count==someArray.count){
            return true
        }
        return false
    }
    func match() -> Bool{
        let card1=cardsSelected[0]
        let card2=cardsSelected[1]
        let card3=cardsSelected[2]
        
        let colorMatch = [card1.color,card2.color,card3.color]
        let numberMatch = [card1.numberOfShapes,card2.numberOfShapes,card3.numberOfShapes]
        let symbolMatch = [card1.symbol,card2.symbol,card3.symbol]
        let shadingMatch = [card1.shading,card2.shading,card3.shading]
        
        return sameOrDifferent(someArray: colorMatch) && sameOrDifferent(someArray: numberMatch) && sameOrDifferent(someArray: symbolMatch) && sameOrDifferent(someArray: shadingMatch)
    }
    mutating func addCardSelection(card:Card){
        
        if let index = cardsSelected.firstIndex(where: {$0.id == card.id}){
            cardsDealt[getIndex(card: card)].isSelected = false
            cardsSelected.remove(at: index)
            return
        }
        if(cardsSelected.count == 3){
            if match(){
                
                for i in 0..<3{

                  cardsMatched.append(cardsSelected[i])
                  cardsDealt.remove(at: getIndex(card: cardsSelected[i])	)

                }
            }else{
                for alreadySelectedcard in cardsSelected{
                    cardsDealt[getIndex(card: alreadySelectedcard)].isSelected = false
                }
            }

            cardsSelected=[]
        }
        cardsDealt[getIndex(card: card)].isSelected = true
        cardsSelected.append(card)

    }
    func printId(cardArray:Array<Card>){
        var idArray = [Int]()
        for i in  0..<cardArray.count{
            idArray.append(cardArray[i].id)
        }
        print(idArray)
    }
    func getIndex(card:Card) -> Int{
        if let index = cardsDealt.firstIndex(where: {$0.id == card.id}){
            return index
        }
        else{
            return -1
        }
        
    }
    struct Card : Identifiable{
        var id: Int
        
        var color:Color
        var symbol:Symbol
        var shading:Shading
        var numberOfShapes:Int
        var isSelected = false
    }
    enum Color : CaseIterable {
        case Red
        case Green
        case Purple
    }
    enum Symbol : CaseIterable {
        case Diamond
        case Rectangle
        case Circle
    }
    enum Shading : CaseIterable {
        case Solid
        case Stripe
        case Open
    }
    
}
