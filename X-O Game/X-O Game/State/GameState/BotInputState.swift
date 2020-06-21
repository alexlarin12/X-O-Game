//
//  BotInputState.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// состояние хода игрока
public class BotInputState: GameState {
    public var inputState: GameViewInput
    public private(set) var isCompleted = false// состояние не завершено
    public let player: Player// для передачи номера игрока
    private(set) weak var gameboard: Gameboard?// объект будет запоминать позиции отметок
    private(set) weak var gameboardView: GameboardXOView?// состояние будет настраивать View игрового поля
    
    init(player: Player,inputState: GameViewInput, gameboard: Gameboard, gameboardView: GameboardXOView) {
        self.player = player
        self.inputState = inputState
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    //метод отображения лейблов (в зависимости от состояния) и установки позиции:
    public func begin() {
        self.inputState.winnerLabel(hide: true)
        self.inputState.firstPlayerTurnLabel(hide: true)
        self.inputState.secondPlayerTurnLabel(hide: false)
        let position: GameboardPosition = generateMovePosition()
             addMark(at: position)
    }
    
    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: self.player, position: position))
        if self.isCompleted { return }
              self.gameboard?.setPlayer(self.player, at: position)
              self.gameboardView?.placeMarkView(player.markViewPrototype.copy(), at: position)
              self.isCompleted = true // режим готовности. состояние изменилось
    }
    private func generateMovePosition() -> GameboardPosition {
           if let freePositions = gameboard?.getFreePositions() {
               let randomMoveId = Int.random(in: 0 ..< freePositions.count)
               return freePositions[randomMoveId]
           }
           else {
               let position = getBruteForcePosition()
               return position
           }
       }
    private func getBruteForcePosition() -> GameboardPosition {
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let newPosition = GameboardPosition(column: column, row: row)
                let isFreePosition = !(gameboard?.contains(player: .first, at: newPosition) ?? true)
                if isFreePosition {
                    return newPosition
                }
            }
        }
        return GameboardPosition(column: 0, row: 0)
    }
}
