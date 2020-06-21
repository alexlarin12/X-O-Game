//
//  PlayerInputState.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// состояние хода игрока
public class PlayerInputState: GameState {
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
    //метод отображения лейблов в зависимости от состояния:
    public func begin() {
        switch self.player {
        case .first:
            self.inputState.firstPlayerTurnLabel(hide: false)//видим
            self.inputState.secondPlayerTurnLabel(hide: true)//скрыт
        case .second:
            self.inputState.firstPlayerTurnLabel(hide: true)//скрыт
            self.inputState.secondPlayerTurnLabel(hide: false)//видим
        }
        self.inputState.winnerLabel(hide: true)//скрыт
    }
    
    public func addMark(at position: GameboardPosition) {
        
        Log(.playerInput(player: self.player, position: position))
        
        guard let gameboardView = self.gameboardView
            , gameboardView.canPlaceMarkView(at: position) else { return }
        self.gameboard?.setPlayer(self.player, at: position)
        self.gameboardView?.placeMarkView(player.markViewPrototype.copy(), at: position)
        self.isCompleted = true // режим готовности. состояние изменилось
     }
    
}
