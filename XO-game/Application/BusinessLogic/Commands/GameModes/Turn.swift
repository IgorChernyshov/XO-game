//
//  MakeTurnCommand.swift
//  XO-game
//
//  Created by Igor Chernyshov on 21/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

struct Turn {
  
  let player: Player
  let position: GameboardPosition
  let gameboard: Gameboard
  let gameboardView: GameboardView
  
  func execute() {
    gameboard.setPlayer(player, at: position)
    gameboardView.removeMarkView(at: position)
    gameboardView.placeMarkView(player.markViewPrototype.copy(), at: position)
  }
  
}
