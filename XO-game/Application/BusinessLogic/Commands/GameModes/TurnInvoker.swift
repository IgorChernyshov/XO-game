//
//  MakeTurnInvoker.swift
//  XO-game
//
//  Created by Igor Chernyshov on 21/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation


final class TurnInvoker {
  
  private let numberOfTurns = 5
  
  private(set) var turnsOfFirstPlayer: [Turn] = []
  private(set) var turnsOfSecondPlayer: [Turn] = []
  
  private let gameMode: GameMode
  
  private let gameboard: Gameboard
  private let gameboardView: GameboardView
  
  init(gameMode: GameMode, gameboard: Gameboard, gameboardView: GameboardView) {
    self.gameMode = gameMode
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  func queueTurn(of player: Player, at position: GameboardPosition) {
    let turn = Turn(player: player, position: position, gameboard: gameboard, gameboardView: gameboardView)
    switch player {
    case .first:
      turnsOfFirstPlayer.append(turn)
    case .second:
      turnsOfSecondPlayer.append(turn)
    }
  }
  
  func noMoreMarks(for player: Player) -> Bool {
    switch player {
    case .first:
      return turnsOfFirstPlayer.count >= numberOfTurns
    case .second:
      return turnsOfSecondPlayer.count >= numberOfTurns
    }
  }
  
  func allMarksArePlaced() -> Bool {
    return (turnsOfFirstPlayer.count, turnsOfSecondPlayer.count) == (turnsOfSecondPlayer.count, numberOfTurns)
  }
  
  func executeTurns() {
    guard allMarksArePlaced() else { return }
    
    for turnNumber in 0..<numberOfTurns {
      let firstPlayerCommand = turnsOfFirstPlayer[turnNumber]
      firstPlayerCommand.execute()
      let secondPlayerCommand = turnsOfSecondPlayer[turnNumber]
      secondPlayerCommand.execute()
    }
  }
  
}
