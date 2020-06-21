//
//  GameboardPosition.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
// позиция на игровой доске
public struct GameboardPosition: Hashable {
    
    public var column: Int
    public var row: Int
}
