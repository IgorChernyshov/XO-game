//
//  MainMenuViewController.swift
//  XO-game
//
//  Created by Igor Chernyshov on 20/03/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func gameModeButtonWasPressed(_ sender: UIButton) {
    guard let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController
      else { return }
    
    switch sender.tag {
    case 1: // Player vs Bot
      gameVC.gameMode = .vsBot
    case 2: // Player vs Player
      gameVC.gameMode = .vsPlayer
    default:
      print("Unknown button was tapped")
      return
    }
    
    present(gameVC, animated: true, completion: nil)
  }
  
}
