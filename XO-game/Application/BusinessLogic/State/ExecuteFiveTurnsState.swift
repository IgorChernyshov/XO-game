//
//  ExecuteFiveTurnsState.swift
//  XO-game
//
//  Created by Igor Chernyshov on 21/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class ExecuteFiveTurnsState: GameState {
  
  var isCompleted: Bool = false
  let turnsInvoker: TurnInvoker?
  
  init(turnsInvoker: TurnInvoker) {
    self.turnsInvoker = turnsInvoker
  }
  
  func begin() {
    turnsInvoker?.executeTurns()
    isCompleted = true
  }
  
  func addMark(at position: GameboardPosition) { }
  
}
