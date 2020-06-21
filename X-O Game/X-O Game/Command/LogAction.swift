//
//  LogAction.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
public enum LogAction {
    case playerInput(player: Player, position: GameboardPosition)
    
    case gameFinished(winner: Player?)
    
    case restartGame
}

public func Log(_ action: LogAction) {
    let command = LogCommand(action: action)
    LoggerInvoker.shared.addLogCommand(command)
}
