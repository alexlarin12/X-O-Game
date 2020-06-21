//
//  ViewController.swift
//  X-O Game
//
//  Created by Alex Larin on 21.06.2020.
//  Copyright © 2020 Alex Larin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var gameMode = GameMode.oneMove
    var gameType = GameType.twoPlayers
    
    @IBOutlet weak var onePlayer: UIButton!
    @IBOutlet weak var twoPlayers: UIButton!
    @IBOutlet weak var fiveMoves: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        switch sender {
            
        case twoPlayers:
            self.gameType = GameType.twoPlayers
            self.gameMode = GameMode.oneMove
            startGame()
        case onePlayer:
            self.gameType = GameType.onePlayer
            self.gameMode = GameMode.oneMove
            startGame()
        case fiveMoves:
            self.gameType = GameType.twoPlayers
            self.gameMode = GameMode.fiveMoves
            startGame()
        default:
            return
        }
    }
}
extension MainViewController {
    
    private func startGame() {
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            guard let destination = segue.destination as? XOGameViewController else { return }
            let gameSettings = GameSettings(mode: self.gameMode, type: self.gameType)
            destination.set(gameSettings: gameSettings)
        }
    }
    
}
