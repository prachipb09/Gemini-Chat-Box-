//
//  ChatBotViewModel.swift
//  Gemini Chat Box
//
//  Created by Prachi Bharadwaj on 25/07/24.
//

import Foundation
import GoogleGenerativeAI

@Observable
class ChatBotViewModel {
    let model: GenerativeModel
    var response : String?
    init() {
        guard let value = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("fatal error: no such key found")
        }
        self.model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: value)
        self.response = nil
    }
    
    
    func generateAnswer(question: String) async throws {
        self.response = nil
        do {
           let response = try await model.generateContent(question)
            self.response = response.text ?? "Bad request try again"
        } catch {
            throw error
        }
    }
}
