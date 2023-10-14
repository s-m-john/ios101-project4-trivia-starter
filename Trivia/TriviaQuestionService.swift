//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Sophia John on 10/13/23.
//


import Foundation

struct TriviaQuestion {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}


class TriviaQuestionService {
    
    static func fetchQuestions(amount: Int, completion: @escaping ([TriviaQuestion]?, Error?) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)") else {
            completion(nil, NSError(domain: "Invalid API URL", code: 0, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "Invalid response status code", code: 0, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(QuestionResponse.self, from: data)
                var responseQuestions = [TriviaQuestion]()
                for question in response.results {
                    let triviaQuestion = TriviaQuestion(
                        category: question.category,
                        type: question.type,
                        difficulty: question.difficulty,
                        question: question.question,
                        correctAnswer: question.correctAnswer,
                        incorrectAnswers: question.incorrectAnswers
                    )
                    responseQuestions.append(triviaQuestion)
                }
                DispatchQueue.main.async {
                    completion(responseQuestions, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    private struct QuestionResponse: Decodable {
        let results: [Question]
    }
    
    private struct Question: Decodable {
        let category: String
        let type: String
        let difficulty: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
    }
}























