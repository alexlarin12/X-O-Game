//
//  MoveInvoker.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import Foundation
class MoveInvoker {
    
    static let shared: MoveInvoker = MoveInvoker()
    private var commands: [MoveCommand] = []
    private let batchSize: Int = 10
    private var timer: Timer?
    private var completion:(() -> Void)?
    
    func addCommand(_ moveCommand: MoveCommand) {
        self.commands.append(moveCommand)
    }
    
    func clear() {
        self.commands.removeAll()
    }
    
    func needExecute() -> Bool {
        let needExecute =  self.commands.count == self.batchSize
        return needExecute
    }
    
    func execute(completion: @escaping () -> Void) {
        self.completion = completion
        commands = updateComandsOrder()
        configureTimer()
    }
    
    private func configureTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.5,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
        }
        
    }
    
    private func updateComandsOrder() -> [MoveCommand] {
        let firstPlayerCommands = [commands[0], commands[1], commands[2], commands[3], commands[4]]
        let secondPlayerCommands = [commands[5], commands[6], commands[7], commands[8], commands[9]]
        
        var newCommandOrder: [MoveCommand] = []
        for i in 0 ..< firstPlayerCommands.count {
            newCommandOrder.append(firstPlayerCommands[i])
            newCommandOrder.append(secondPlayerCommands[i])
        }
        return newCommandOrder
    }
    
    @objc private func updateTimer() {
        if commands.count > 0 {
            commands[0].execute()
            commands.remove(at: 0)
        } else {
            completion?()
            timer?.invalidate()
            timer = nil
        }
    }
}
