//
//  Gameboard.swift
//  XO-game
//
//  Created by Evgeny Kireev on 27/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public final class Gameboard {
  
  // MARK: - Properties
  
  private lazy var positions: [[Player?]] = initialPositions()
  
  // MARK: - public
  
  public func setPlayer(_ player: Player, at position: GameboardPosition) {
    positions[position.column][position.row] = player
  }
  
  public func clear() {
    self.positions = initialPositions()
  }
  
  public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
    for position in positions {
      guard contains(player: player, at: position) else {
        return false
      }
    }
    return true
  }
  
  public func contains(player: Player, at position: GameboardPosition) -> Bool {
    let (column, row) = (position.column, position.row)
    return positions[column][row] == player
  }
  
  public func getFreePositions() -> [GameboardPosition] {
    var freePositions: [GameboardPosition] = []
    
    for column in 0 ..< GameboardSize.columns {
      for row in 0 ..< GameboardSize.rows {
        if positions[column][row] == nil {
          freePositions.append(GameboardPosition(column: column, row: row))
        }
      }
    }
    
    return freePositions
  }
  
  public func allPositionsAreFilled() -> Bool {
    for rows in positions {
      for position in rows {
        if position == nil {
          return false
        }
      }
    }
    return true
  }
  
  // MARK: - Private
  
  private func initialPositions() -> [[Player?]] {
    var positions: [[Player?]] = []
    for _ in 0 ..< GameboardSize.columns {
      let rows = Array<Player?>(repeating: nil, count: GameboardSize.rows)
      positions.append(rows)
    }
    return positions
  }
}
