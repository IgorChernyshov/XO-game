//
//  LogCommand.swift
//  XO-game
//
//  Created by Igor Chernyshov on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class LogCommand {
  
  let action: LoggedActionType
  
  init(action: LoggedActionType) {
    self.action = action
  }
  
  var logMessage: String {
    switch action {
    case .playerInput(let player, let position):
      return "\(player) placed mark at \(position)"
    case .gameFinished(let winner):
      if let winner = winner {
        return "\(winner) won the game"
      } else {
        return "It's a tie"
      }
    case .restartGame:
      return "The game was restarted"
    }
  }
  
}
