//
//  ViewController.swift
//  ApplePie
//
//  Created by Сырлыбай Рамазан on 26.03.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!

    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandencest", "bug", "program"]
    let incorrectMoveAllowed = 5;
    var totalWins = 0{
        didSet{
            newRound()
        }
    }
    var totalLosses = 0{
        didSet{
            newRound()
        }
    }
    var currentGame: Game!;
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false;
        if let letterString = sender.titleLabel?.text {
            let letter = Character(letterString.lowercased());
            currentGame.playerGuessed(letter: letter);
            updateUI();
            updateGameState()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound();
    }
    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word:newWord, incorrectMovesRemaining: incorrectMoveAllowed, guessedLetters: [])
            updateUI();
            enableLetterButtons(true);
        } else{enableLetterButtons(false);}
        
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins) Total losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else{
            updateUI()
        }
    }

}

