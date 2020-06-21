//
//  MoveComand.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
class MoveCommand {
    
    let position: GameboardPosition
    let player: Player
    let gameboard: Gameboard
    let gameboardView: GameboardXOView
    
    init(position: GameboardPosition, player: Player, gameboard: Gameboard, gameboardView: GameboardXOView) {
        self.position = position
        self.player = player
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    func execute() {
        self.gameboard.setPlayer(player, at: position)
        let markView = self.player.markViewPrototype
        self.gameboardView.placeSurelyMarkView(markView, at: self.position)
    }
    
}
