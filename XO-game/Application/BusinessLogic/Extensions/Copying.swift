//
//  Copying.swift
//  XO-game
//
//  Created by Igor Chernyshov on 19/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
  init(_ prototype: Self)
}

extension Copying {
  func copy() -> Self {
    return type(of: self).init(self)
  }
}
