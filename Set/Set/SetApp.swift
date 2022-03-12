//
//  SetApp.swift
//  Set
//
//  Created by Radha Natesan on 2/28/22.
//

import SwiftUI

@main
struct SetApp: App {
    let game = SetGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
