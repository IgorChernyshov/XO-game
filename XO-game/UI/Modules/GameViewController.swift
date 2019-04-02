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
  private var turnInvoker: TurnInvoker?
  private let xoBot = xoEasyBot()
  private lazy var referee = Referee(gameboard: gameboard)
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
    switch gameMode ?? .vsBot {
    case .vsBot, .vsPlayer:
      switchToPlayerInputState(with: .first)
    case .fiveTurns:
      self.turnInvoker = TurnInvoker(gameMode: .fiveTurns, gameboard: gameboard, gameboardView: gameboardView)
      switchToPlayerInputFiveTurnsState(with: .first)
    }
  }
  
  private func goToNextState() {
    switch gameMode ?? .vsBot {
    case .vsBot:
      determineWinner()
      if let playerInputState = currentState as? PlayerInputState {
        switchToBotInputState(with: playerInputState.player.next)
      }
      if let playerInputState = currentState as? BotInputState {
        switchToPlayerInputState(with: playerInputState.player.next)
      }
    case .vsPlayer:
      determineWinner()
      if let playerInputState = currentState as? PlayerInputState {
        switchToPlayerInputState(with: playerInputState.player.next)
      }
    case .fiveTurns:
      if let playerInputState = currentState as? PlayerInputFiveTurnsState {
        if playerInputState.player == .first {
          switchToPlayerInputFiveTurnsState(with: playerInputState.player.next)
        } else {
          switchToPlayerInputFiveTurnsExecuteState()
          determineWinner()
        }
      }
    }
  }
  
  private func determineWinner() {
    if let winner = self.referee.determineWinner() {
      currentState = GameEndedState(winner: winner, gameViewController: self)
      return
    }
    switch gameMode ?? .vsBot {
    case .vsBot, .vsPlayer:
      if self.gameboard.allPositionsAreFilled() {
        currentState = GameEndedState(winner: nil, gameViewController: self)
      }
    case .fiveTurns:
      currentState = GameEndedState(winner: nil, gameViewController: self)
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
  
  private func switchToPlayerInputFiveTurnsState(with player: Player) {
    guard let turnInvoker = turnInvoker else { return }
    currentState = PlayerInputFiveTurnsState(player: player,
                                    markViewPrototype: player.markViewPrototype,
                                    gameViewController: self,
                                    gameboard: gameboard,
                                    gameboardView: gameboardView,
                                    turnInvoker: turnInvoker)
  }
  
  private func switchToPlayerInputFiveTurnsExecuteState() {
    guard let turnInvoker = turnInvoker else { return }
    currentState = ExecuteFiveTurnsState(turnsInvoker: turnInvoker)
  }
  
  @IBAction func restartButtonTapped(_ sender: UIButton) {
    Log(.restartGame)
    
    gameboard.clear()
    gameboardView.clear()
    goToFirstState()
  }
  
}
