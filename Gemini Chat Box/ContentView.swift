//
//  ContentView.swift
//  Gemini Chat Box
//
//  Created by Prachi Bharadwaj on 25/07/24.
//

import SwiftUI

struct ContentView: View {
    private let viewModel = ChatBotViewModel()
    @State private var textField = ""
    @State private var showLoader: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    if let response = viewModel.response {
                        Text(response)
                    }
                }
            }
                Spacer()
                
                HStack {
                    TextField(text: $textField) {
                        Text("Ask me....")
                    }.onSubmit {
                        sendQuestion(textField)
                    }
                    
                    Button(action: {
                        sendQuestion(textField)
                        
                    }, label: {
                        Image(systemName: "arrow.up.circle")
                            .foregroundColor(.blue)
                    })
                }
            
        }
            .padding()
            .showLoader(showLoader: showLoader)
        
    }
    
    func sendQuestion(_ question: String) {
        showLoader = true
        textField = ""
        if !question.isEmpty {
            Task {
                try await viewModel.generateAnswer(question: question)
                showLoader = false
                
            }
        }
        
    }
}

struct ProgressViewScreen: ViewModifier {
    var showLoader: Bool
    func body(content: Content) -> some View {
        content
            .overlay {
            if showLoader {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}

extension View {
    func showLoader(showLoader: Bool) -> some View {
        return modifier(ProgressViewScreen(showLoader: showLoader))
    }
}

#Preview {
    ContentView()
}
