//
//  ViewController.swift
//  FlagGame
//
//  Created by Rob Ranf on 10/7/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        countries.append("japan")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        // We're using the shuffle() method here which shuffles the order of the array in place vs shuffled() which randomizes at the return value
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased() + " (Score: \(score))"
    }
    
    func newGame(action: UIAlertAction! = nil) {
        score = 0
        askQuestion()
    }
    
    // Remember that IBAction is the opposite way of IBOutlet. IBAction makes
    // something in the Interface Builder trigger code and IBOutlet connects
    // code to something in the Interface Builder.
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            questionsAsked += 1
        } else {
            title = "Wrong! That's the flag of \(String(countries[sender.tag].uppercased()))"
            score -= 1
            questionsAsked += 1
        }
        
        // For the preferredStyle, we can choose .alert for a popup box in the middle of the screen (to tell user of a situation change) or we can use .actionSheet which brings up options from the bottom (for asking users to choose from a set of options)
        // On addAction, the handler is looking for a closure; we're passing it the askQuestion method that we already defined. Remember, a closure in its most basic state is just a function that is passed to another function as an argument
        var ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        if questionsAsked <= 9 {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            ac = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: newGame))
            present(ac, animated: true)
        }
        // MARK: - Bug: Need to fix score on new game function; currently it keeps the score at zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
}
