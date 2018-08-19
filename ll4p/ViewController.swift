//
//  ViewController.swift
//  ll4p
//
//  Created by Matt Sheppard on 8/18/18.
//  Copyright © 2018 Matt Sheppard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theBtn: UIButton!

    var buttons = [UIButton]()
    
    let words = ["The", "Left", "Lane", "Is", "For", "Passing"]
    var shuffled = [0, 2, 1, 3, 4, 5] //Testing oprder, two swapped
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Layout the buttons we need, adding to array
        let width = view.frame.width
        let height = view.frame.height
        let bHeight = Int(height - 100.0) / words.count
        
        var y:Int = 100
        for i in shuffled {
            let word = words[i]
            let button = UIButton(frame: CGRect(x: 0, y: y, width: Int(width), height: 50))
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.setTitle(word, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            self.view.addSubview(button)
            buttons.append(button)
            
            y += bHeight

        }
    }

    func shuffleList() {
        
    }
    
    func lowestButton() -> String {
        for word in words {
            for button in buttons {
                if !button.isHidden {
                    print("Comparing \(word) to \(button.currentTitle!)")
                    if button.currentTitle == word {
                        print("Found First non hidden word")
                        return word
                    }
                }
            }
        }
        return "this should never happen" // great shame... refactor me please
    }
    
    @objc func buttonAction(sender: UIButton!) {
        // find the lowest visible button
        // this is horrible
        
        let word = lowestButton()
        
        print("Button tapped")
        if sender.currentTitle == word {
            sender.isHidden = true
        }
    }
    
}

