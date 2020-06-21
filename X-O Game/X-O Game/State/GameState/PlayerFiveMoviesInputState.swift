//
//  PlayerFiveMoviesInputState.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
class PlayerFiveMovesInputState: GameState {
    
    var isCompleted: Bool = false
    let player: Player
    private let maximumMoveCounts = 5
    var inputState: GameViewInput
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardXOView?
    private var playerInputMoves: [GameboardPosition] = []
    private let moveInvoker = MoveInvoker.shared
    
    init(player: Player, inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardXOView) {
        self.player = player
        self.inputState = inputState
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
}

// MARK: - Internal functions
extension PlayerFiveMovesInputState {
    
    internal func begin() {
        switch self.player {
        case .first:
            self.inputState.firstPlayerTurnLabel(hide: false)
            self.inputState.secondPlayerTurnLabel(hide: true)
        case .second:
            self.inputState.firstPlayerTurnLabel(hide: true)
            self.inputState.secondPlayerTurnLabel(hide: false)
        }
        self.inputState.winnerLabel(hide: true)
    }
    
    func addMark(at position: GameboardPosition) {
        if self.isCompleted { return }
        addMove(at: position)
        if playerInputMoves.count == maximumMoveCounts {
            self.isCompleted = true
        }
    }
    
    private func addMove(at position: GameboardPosition)  {
        playerInputMoves.append(position)
        
        guard let gameboard = gameboard,
            let gameboardView = gameboardView else { return }
        let command = MoveCommand(position: position, player: player, gameboard: gameboard, gameboardView: gameboardView)
        moveInvoker.addCommand(command)
    }
    
}
