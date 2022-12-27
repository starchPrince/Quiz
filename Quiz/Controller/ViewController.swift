//
//  ViewController.swift
//  Quiz
//
//  Created by Сергей Буланов on 27.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageQuestions: UIImageView!
    @IBOutlet weak var textQuestions: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var quizProgress: UIProgressView!
    
    
    var brainQuiz = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quizProgress.progress = brainQuiz.getProgress()
        
        imageQuestions.image = brainQuiz.getImage()
        imageQuestions.layer.cornerRadius = 20
        imageQuestions.layer.masksToBounds = true
        
        textQuestions.text = brainQuiz.getTextQuestion()
        textQuestions.textColor = brainQuiz.getColor()
        
        scoreLabel.text = "Правильных ответов: \(brainQuiz.getScore())"
        
    }

    @IBAction func userAnswerButtonTap(_ sender: UIButton) {
        
        let userAnswer = sender.titleLabel?.text ?? "Правда"
        let  rightAnswer = brainQuiz.checkAnswer(userAnswer: userAnswer)
        
        if rightAnswer {
            sender.backgroundColor = .green
        } else {
            sender.backgroundColor = .red
            // Неправильный ответ
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }

        falseButton.isEnabled = false
        trueButton.isEnabled = false
 
        // Есть ли ещё вопросы?
        if brainQuiz.nextQuestion() {
            let alert = UIAlertController(title: "Конец викторины", message: "Хотите сыграть еще раз?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
                self.brainQuiz.score = 0
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.changeQuestions), userInfo: nil, repeats: false)
                
            }
            let noAction = UIAlertAction(title: "Нет", style: .cancel) { _ in
                exit(0)
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            present(alert, animated: true)
        } else {
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(changeQuestions), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func changeQuestions() {
        textQuestions.text = brainQuiz.getTextQuestion()
        textQuestions.textColor = brainQuiz.getColor()
        
        imageQuestions.image = brainQuiz.getImage()
        
        quizProgress.progress = brainQuiz.getProgress()
        
        scoreLabel.text = "Получено очков: \(brainQuiz.getScore()) "
        
        trueButton.backgroundColor = UIColor.white
        falseButton.backgroundColor = UIColor.white
        
        falseButton.isEnabled = true
        trueButton.isEnabled = true
    }

}

