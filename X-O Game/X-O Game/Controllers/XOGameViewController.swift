//
//  GameViewController.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

// протокол работы с UI
public protocol GameViewInput: UIViewController {
   // func incorrectMoveLabel(hide: Bool)
    func firstPlayerTurnLabel(hide: Bool)
    func secondPlayerTurnLabel(hide: Bool)
    func winnerLabel(hide: Bool)
    func winnerLabel(text: String)
}

// экран на котором будет происходить все действие
class XOGameViewController: UIViewController {

    @IBOutlet weak var firstPlayerTurnLabel: UILabel!
    @IBOutlet weak var gameboardView: GameboardXOView!
    @IBOutlet weak var secondPlayerTurnLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    private let gameboard = Gameboard()
    private var gameSettings = GameSettings() //ячейка где хранится инфа о выбранной игре
    private var currentState: GameState! {
        didSet {
            self.currentState.begin()
        }
    }
    private var currentPlayer: Player = .first
    lazy var referee = Referee(gameboard: self.gameboard)
    private let moveInvoker = MoveInvoker.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchToFirstState()
        configureViews()
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
        
    }
}
// ПОЛУЧЕНИЕ УСТАНОВОК ИГРЫ ИЗ MainViewController:
extension XOGameViewController {
    public func set(gameSettings: GameSettings) {
        self.gameSettings = gameSettings
    }
    
}

extension XOGameViewController: GameViewInput {
    
  
    // установка логики UILabels:

    func firstPlayerTurnLabel(hide: Bool) {
        self.firstPlayerTurnLabel.isHidden = hide
    }
    func secondPlayerTurnLabel(hide: Bool) {
        self.secondPlayerTurnLabel.isHidden = hide
    }
   
    func winnerLabel(hide: Bool)  {
        self.winnerLabel.isHidden = hide
    }
    func winnerLabel(text: String) {
        self.winnerLabel.text = text
        self.winnerLabel.textColor = .red
    }
}
// СОСТОЯНИЯ ЛОГИКИ ИГРЫ:
extension XOGameViewController {
 // метод установки начального состояния:
    func switchToFirstState() {
        self.swithToPlayerInputState(with: .first)
    }
  // метод установки следующего состояния
    func switchToNextState() {
        if false == self.currentState.isCompleted { return }
        
        switch gameSettings.gameMode {
        case .oneMove:
            oneMoveStateChanger()
            
        case .fiveMoves:
            fiveMovesStateChanger()
        }
    }
}
// СОСТОЯНИЕ ИГРЫ "5 ХОДОВ"
extension XOGameViewController {

    private func fiveMovesStateChanger() {
        if moveInvoker.needExecute() {
            switchToFinishedState()
        } else {
            self.switchSettingsByGameSettings()
        }
    }
    
    private func switchToFinishedState() {
        restartButton(enable: false)
        self.moveInvoker.execute { [weak self] in
            self?.restartButton(enable: true)
            if let winner = self?.referee.determineWinner() {
                self?.switchToFinishedState(with: winner)
            } else {
                self?.switchToFinishedState(with: nil)
            }
        }
    }
    
    func restartButton(enable: Bool) {
        self.restartButton.isEnabled = enable
    }
}
// СОСТОЯНИЕ ИГРЫ В ОДИН ХОД:
extension XOGameViewController {
    
    private func oneMoveStateChanger() {
        if let winner = self.referee.determineWinner() {
            self.switchToFinishedState(with: winner)
            
        } else if self.gameboard.areAllPositionsFullfilled() {
            self.switchToFinishedState(with: nil)
            
        } else {
            self.switchSettingsByGameSettings()
        }
    }
    // метод переключения
    private func switchStateByGameType() {
        self.currentPlayer = self.currentPlayer.next
        if self.currentPlayer == .first {
            self.swithToPlayerInputState(with: self.currentPlayer)
        } else if self.gameSettings.gameType == GameType.twoPlayers {
            self.swithToPlayerInputState(with: self.currentPlayer)
        } else {
            self.swithToBotInputState(with: self.currentPlayer)
            self.switchToNextState()
        }
    }
    
    // метод переключения состояния ("один ход" или "пять ходов")
    private func swithToPlayerInputState(with player: Player) {
        if gameSettings.gameMode == GameMode.oneMove {
            self.currentState = PlayerInputState(player: player,
                                                 inputState: self,
                                                 gameboard: self.gameboard,
                                                 gameboardView: self.gameboardView)
        } else {
            self.currentState = PlayerFiveMovesInputState(player: player,
                                                          inputState: self,
                                                          gameboard: self.gameboard,
                                                          gameboardView: self.gameboardView)
        }
    }
    // переключение текущего состояния на состояние "игра с ботом"
    private func swithToBotInputState(with player: Player) {
       
        self.currentState = BotInputState(player: player,
                                          inputState: self,
                                          gameboard: self.gameboard,
                                          gameboardView: self.gameboardView)
    }
    // переключение текущего состояния на состояние "конец игры"
    private func switchToFinishedState(with winner: Player?) {
        self.currentState = GameEndedState(winner: winner, inputState: self)
    }
    
    private func switchSettingsByGameSettings() {
        switchStateByGameType()
    }
    
}



extension XOGameViewController {
    
    private func configureViews() {
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.currentState.addMark(at: position)
            self.switchToNextState()
        }
    }
    
}
