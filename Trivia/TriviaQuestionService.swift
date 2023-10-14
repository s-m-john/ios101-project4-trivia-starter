//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Sophia John on 10/13/23.
//


import Foundation

class TriviaQuestionService {
    private let apiUrl = "https://opentdb.com/api.php?amount=5" // Modify the URL as needed

    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?, Error?) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(nil, NSError(domain: "Invalid API URL", code: 0, userInfo: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let triviaQuestions = try decoder.decode([TriviaQuestion].self, from: data)
                completion(triviaQuestions, nil)
            } catch let decodingError {
                completion(nil, decodingError)
            }
        }

        task.resume()
    }
}
