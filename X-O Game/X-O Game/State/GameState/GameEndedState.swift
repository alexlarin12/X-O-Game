//
//  GameEndedState.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
public class GameEndedState: GameState {
    public var inputState: GameViewInput
    
    
    public let isCompleted: Bool = false
    
    public let winner: Player?
    private(set) weak var gameViewController: XOGameViewController?
    
    init(winner: Player?, inputState: GameViewInput) {
        self.winner = winner
        self.inputState = inputState
    }
    
    public func begin() {
        Log(.gameFinished(winner: self.winner))
        self.inputState.firstPlayerTurnLabel(hide: true)
        self.inputState.secondPlayerTurnLabel(hide: true)
        self.inputState.winnerLabel(hide: false)
        var text = "No winner"
        if let winner = self.winner {
            text = winner.winnerText()
        }
        self.inputState.winnerLabel(text: text)    }
    
    public func addMark(at position: GameboardPosition) {   }
    
   
}
