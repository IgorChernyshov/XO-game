//
//  GameEndedState.swift
//  XO-game
//
//  Created by Igor Chernyshov on 18/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
  
  let isCompleted = false
  
  let winner: Player?
  private(set) weak var gameViewController: GameViewController?
  
  init(winner: Player?, gameViewController: GameViewController) {
    self.winner = winner
    self.gameViewController = gameViewController
  }
  
  public func begin() {
    self.gameViewController?.winnerLabel.isHidden = false
    if let winner = winner {
      self.gameViewController?.winnerLabel.text = self.winnerName(from: winner) + " win"
    } else {
      self.gameViewController?.winnerLabel.text = "No winner"
    }
    self.gameViewController?.firstPlayerTurnLabel.isHidden = true
    self.gameViewController?.secondPlayerTurnLabel.isHidden = true
    Log(.gameFinished(winner: winner))
  }
  
  public func addMark(at position: GameboardPosition) { }
  
  private func winnerName(from winner: Player) -> String {
    switch winner {
    case .first: return "1st player"
    case .second: return "2nd player"
    }
  }
}
