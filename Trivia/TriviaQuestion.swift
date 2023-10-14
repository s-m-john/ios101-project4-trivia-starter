//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation

struct QuestionResponse: Decodable {
    let results: [Question]
    
    enum CodingKeys: String, CodingKey {
        case results
    }

    struct Question: Decodable {
        let category: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
    }
}
