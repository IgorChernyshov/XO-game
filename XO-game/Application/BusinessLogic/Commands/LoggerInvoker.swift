//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Igor Chernyshov on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

final class LoggerInvoker {
  
  static let instance = LoggerInvoker()
  
  private init() { }
  
  private let logger = Logger()
  private let batchSize = 3
  private var commands: [LogCommand] = []
  
  func addLogCommand(_ command: LogCommand) {
    commands.append(command)
    executeCommandsIfNeeded()
  }
  
  private func executeCommandsIfNeeded() {
    guard commands.count >= batchSize else { return }
    
    commands.forEach { logger.writeMessageToLog($0.logMessage) }
    commands = []
  }
  
}
