//
//  QuizBrain.swift
//  Quiz
//
//  Created by Сергей Буланов on 27.12.2022.
//

import Foundation
import UIKit

struct QuizBrain {
    
    
    let  questions = [
        Question(text: "Токио всегда был столицей Японии", answer: "Ложь", color: UIColor.black, image: UIImage(named: "tokio")!),
        Question(text: "Окружность - это замкнутная линия", answer: "Правда", color: UIColor.black, image: UIImage(named: "circle")!),
        Question(text: "Ромб - это параллелограмм с равными сторонами", answer: "Правда", color: UIColor.black, image: UIImage(named: "romb")!),
        Question(text: "Богота - столица Уругвая", answer: "Ложь", color: UIColor.black, image: UIImage(named: "uruguay")!)
    ]
    
    var numQuestions = 0
    var score = 0
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        if userAnswer == questions[numQuestions].answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    func getTextQuestion() -> String {
        return questions[numQuestions].text
    }
    
    func getProgress() -> Float {
        let progress = Float(numQuestions + 1) / Float(questions.count)
        return progress
    }
    
    func getColor() -> UIColor {
        return questions[numQuestions].color
    }
    
    func getImage() -> UIImage {
        return questions[numQuestions].image
    }
    
    mutating func nextQuestion() -> Bool {
        if numQuestions + 1  < questions.count {
            numQuestions += 1
            return false
        } else {
            numQuestions = 0
            return true
        }
    }
        
}


