//
//  GameState.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// протокол для реализации паттерна State
public protocol GameState {
    var isCompleted: Bool { get }// показывает выполненно ли состояние. можно ли перейти к следующему
    var inputState: GameViewInput { set get } // получает-передает состояние UI
    func begin() //реализация следующего состояния. подготовка внешнего вида илогики
    func addMark(at position: GameboardPosition)// добавляем крестик или нолик на игровое поле
}
