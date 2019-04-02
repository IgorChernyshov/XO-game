//
//  xoEasyBot.swift
//  XO-game
//
//  Created by Igor Chernyshov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

class xoEasyBot {
  
  func selectPosition(at gameboard: Gameboard) -> GameboardPosition {
    return chooseRandomPosition(at: gameboard)
  }
  
  private func chooseRandomPosition(at gameboard: Gameboard) -> GameboardPosition {
    let freePositions = gameboard.getFreePositions()
    let randomPositionNumber = Int.random(in: 0..<freePositions.count)
    let randomPosition = freePositions[randomPositionNumber]
    
    return randomPosition
  }
  
}
