//
//  PlayerInputFiveTurnsState.swift
//  XO-game
//
//  Created by Igor Chernyshov on 21/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class PlayerInputFiveTurnsState: GameState {
  
  private(set) var isCompleted: Bool = false
  
  let player: Player
  let markViewPrototype: MarkView
  private(set) weak var turnInvoker: TurnInvoker?
  private(set) weak var gameViewController: GameViewController?
  private(set) weak var gameboard: Gameboard?
  private(set) weak var gameboardView: GameboardView?
  
  init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView, turnInvoker: TurnInvoker) {
    self.player = player
    self.markViewPrototype = markViewPrototype
    self.turnInvoker = turnInvoker
    self.gameViewController = gameViewController
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func begin() {
    switch self.player {
    case .first:
      self.gameViewController?.firstPlayerTurnLabel.isHidden = false
      self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    case .second:
      self.gameViewController?.firstPlayerTurnLabel.isHidden = true
      self.gameViewController?.secondPlayerTurnLabel.isHidden = false
    }
    self.gameViewController?.winnerLabel.isHidden = true
  }
  
  func addMark(at position: GameboardPosition) {    
    turnInvoker?.queueTurn(of: player, at: position)
    gameboardView?.placeMarkView(markViewPrototype.copy(), at: position)
    
    let playerMadeAllMoves = turnInvoker?.noMoreMarks(for: player) ?? false
    
    if playerMadeAllMoves {
      gameboard?.clear()
      gameboardView?.clear()
    }
    isCompleted = playerMadeAllMoves
  }
  
}
