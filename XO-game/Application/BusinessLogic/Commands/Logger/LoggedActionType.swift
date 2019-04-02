//
//  LoggedActionType.swift
//  XO-game
//
//  Created by Igor Chernyshov on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum LoggedActionType {
  
  case playerInput(player: Player, position: GameboardPosition)
  
  case gameFinished(winner: Player?)
  
  case restartGame
  
}

public func Log(_ action: LoggedActionType) {
  let command = LogCommand(action: action)
  LoggerInvoker.instance.addLogCommand(command)
}
