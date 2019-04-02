//
//  BotInputState.swift
//  XO-game
//
//  Created by Igor Chernyshov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public class BotInputState: GameState {
  
  public private(set) var isCompleted: Bool = false
  
  public let player: Player
  public let markViewPrototype: MarkView
  private(set) weak var gameViewController: GameViewController?
  private(set) weak var gameboard: Gameboard?
  private(set) weak var gameboardView: GameboardView?
  
  init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
    self.player = player
    self.markViewPrototype = markViewPrototype
    self.gameViewController = gameViewController
    self.gameboard = gameboard
    self.gameboardView = gameboardView
  }
  
  public func begin() {
    addMark(at: selectedTurnPosition())
  }
  
  public func addMark(at position: GameboardPosition) {
    guard let gameboardView = self.gameboardView,
      gameboardView.canPlaceMarkView(at: position)
      else { return }
    
    Log(.playerInput(player: self.player, position: position))
    self.gameboard?.setPlayer(self.player, at: position)
    self.gameboardView?.placeMarkView(self.markViewPrototype.copy(), at: position)
    self.isCompleted = true
  }
  
  private func selectedTurnPosition() -> GameboardPosition {
    guard let freePositions = gameboard?.getFreePositions() else { return GameboardPosition(column: 0, row: 0)}
    let randomPositionNumber = Int.random(in: 0..<freePositions.count)
    let randomPosition = freePositions[randomPositionNumber]
    
    return randomPosition
  }
  
}
