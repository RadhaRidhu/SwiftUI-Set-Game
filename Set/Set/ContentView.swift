//
//  ContentView.swift
//  Set
//
//  Created by Radha Natesan on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game:SetGameViewModel
    var body: some View {
        VStack{
            gameBody()
            HStack{
                discardedPile()
                Spacer()
                deck()
            }
          
        }
        
     
    }
    
    @State private var discardedCards = [SetGameViewModel.Card]()
    @Namespace private var dealingNamespace
    @Namespace private var discardNamespace

    private func gameBody() -> some View{
        VStack{
            AspectVGrid(items: game.cardsDealt, aspectRatio: 2/3, content: {card in
                CardView(card: card,game: game)
                    .padding(1)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .matchedGeometryEffect(id: card.id, in: discardNamespace)
                    .onTapGesture {
                        
                        game.selectCard(card:card)
                        withAnimation()
                        {
                            getMatchedCards()
                        }
                        
                        
                        }
            })

        }
    }
    private func isUndealt(card:SetGameViewModel.Card)->Bool{
        return !game.cardsDealt.contains(where: {$0.id == card.id}) &&
        !game.cardsMatched.contains(where: {$0.id == card.id})
    }
    private func dealAnimation(for card:SetGameViewModel.Card)->Animation{
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}){
            delay = Double(index) * CardConstants.totalDealDuration/Double(game.cards.count)
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    private func getMatchedCards(){
        for card in game.cardsMatched{
            if !discardedCards.contains(where: {$0.id == card.id}){
                discardedCards.append(card)
            }
        }

    }
    private func zIndex(of card:SetGameViewModel.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    private func deck()->some View{
        ZStack{
            ForEach(game.cards.filter(isUndealt)){card in
                CardView(card: card, game: game)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeight)
        .padding(5)
        .onTapGesture {
            withAnimation(Animation.easeInOut(duration: CardConstants.dealDuration).delay(0.1)){
                
                game.dealMore()
                getMatchedCards()
            }
            
        }
        
    }
    private func discardedPile()->some View{
        ZStack{
            ForEach(discardedCards){card in
                CardView(card: card, game: game)
                    .matchedGeometryEffect(id: card.id, in: discardNamespace)

            }
        }
        .frame(width: CardConstants.unDealtWidth, height: CardConstants.unDealtHeight)
        .padding(5)
        
    }
    
    private struct CardConstants{
        static let color = Color.red
        static let aspectRatio:CGFloat = 2/3
        static let dealDuration:Double = 0.5
        static let totalDealDuration:Double = 2
        static let unDealtHeight:CGFloat = 90
        static let unDealtWidth:CGFloat = unDealtHeight * aspectRatio
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game=SetGameViewModel()
        ContentView(game: game)
    }
}
