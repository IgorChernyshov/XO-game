//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet var gameboardView: GameboardView!
  @IBOutlet var firstPlayerTurnLabel: UILabel!
  @IBOutlet var secondPlayerTurnLabel: UILabel!
  @IBOutlet var winnerLabel: UILabel!
  @IBOutlet var restartButton: UIButton!
  
  private let gameboard = Gameboard()
  private let xoBot = xoEasyBot()
  private lazy var referee = Referee(gameboard: self.gameboard)
  private var currentState: GameState! {
    didSet {
      self.currentState.begin()
    }
  }
  
  var gameMode: GameMode?
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.goToFirstState()
    
    gameboardView.onSelectPosition = { [weak self] position in
      guard let self = self else { return }
      
      self.currentState.addMark(at: position)
      if self.currentState.isCompleted {
        self.goToNextState()
      }
    }
  }
  
  private func goToFirstState() {
    switchToPlayerInputState(with: .first)
  }
  
  private func goToNextState() {
    if let winner = self.referee.determineWinner() {
      currentState = GameEndedState(winner: winner, gameViewController: self)
      return
    } else if self.gameboard.allPositionsAreFilled() {
      currentState = GameEndedState(winner: nil, gameViewController: self)
    }
    switch gameMode ?? .vsBot {
    case .vsBot:
      if let playerInputState = currentState as? PlayerInputState {
        switchToBotInputState(with: playerInputState.player.next)
      }
      if let playerInputState = currentState as? BotInputState {
        switchToPlayerInputState(with: playerInputState.player.next)
      }
    case .vsPlayer:
      if let playerInputState = currentState as? PlayerInputState {
        switchToPlayerInputState(with: playerInputState.player.next)
      }
    }
  }
  
  private func switchToPlayerInputState(with player: Player) {
    currentState = PlayerInputState(player: player,
                                    markViewPrototype: player.markViewPrototype,
                                    gameViewController: self,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView)
  }
  
  private func switchToBotInputState(with player: Player) {
    currentState = BotInputState(player: player,
                                 markViewPrototype: player.markViewPrototype,
                                 gameViewController: self,
                                 gameboard: gameboard,
                                 gameboardView: gameboardView)
  }
  
  @IBAction func restartButtonTapped(_ sender: UIButton) {
    Log(.restartGame)
  }
  
}
