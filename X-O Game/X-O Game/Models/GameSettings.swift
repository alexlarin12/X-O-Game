//
//  GameSettings.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// структура настройки игры (по умолчанию 2 игрока, по одному ходу)
struct GameSettings {
    
    let gameMode: GameMode
    let gameType: GameType
    
    init() {
        self.gameMode = GameMode.oneMove
        self.gameType = GameType.twoPlayers
    }
    
    init(mode: GameMode, type: GameType) {
        self.gameMode = mode
        self.gameType = type
    }
}
