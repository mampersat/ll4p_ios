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

    @IBOutlet weak var lblAvg: UILabel!
    @IBOutlet weak var lblBest: UILabel!
    @IBOutlet weak var lblLast: UILabel!

    var buttons = [UIButton]()
    
    let words = ["The", "Left", "Lane", "Is", "For", "Passing"]
    var shuffled = [0, 1, 2, 3, 4, 5] // First time in, go in order
    var start = DispatchTime.now()
    var end = DispatchTime.now()
    var completions = 0
    var totalTime = 0.0
    var best = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Layout the buttons we need, adding to buttons array
        let width = view.frame.width
        let height = view.frame.height
        let bHeight = Int(height - 100.0) / (words.count + 1)
        
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
        shuffled = shuffled.shuffled()
        for i in 0...shuffled.count-1 {
            buttons[i].setTitle(words[shuffled[i]], for : .normal)
            buttons[i].isHidden = false
        }
    }
    
    func lowestButton() -> String {
        for word in words {
            for button in buttons {
                if !button.isHidden {
                    if button.currentTitle == word {
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
            if word == "Passing" {
                end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds // <<<<< Difference in nano seconds (UInt64)
                let timeInterval = Double(nanoTime) / 1_000_000_000 // Technically could overflow for long running tests
                let last = round(timeInterval * 1000) / 1000
                
                if (best == 0.0) || (last < best) {
                    best = last
                }
                
                completions += 1
                totalTime += last
                let avg = round( totalTime / Double(completions) * 1000) / 1000
                
                lblLast.text = "\(last)"
                lblAvg.text = "\(avg)"
                lblBest.text = "\(best)"
                
                shuffleList()
                start = DispatchTime.now()
            }
        }
    }
    
}

