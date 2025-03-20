//
//  APIError.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 27.02.2025.
//

import UIKit


enum APIError: Error {
    case noInternet
    case unauthorized
    case requestFailed(statusCode: Int)
    case unknown
}

final class OpenAIService {
    
    func sendMessage(apiKey: String, message: String, completion: @escaping (Result<String, APIError>) -> Void) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            completion(.failure(.unknown))
            return
        }
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [["role": "user", "content": message]]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Ошибка сети: \(error.localizedDescription)")
                completion(.failure(.noInternet))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("❌ Ошибка: не получен HTTP-ответ")
                completion(.failure(.unknown))
                return
            }
            
            print("🔄 Статус-код ответа: \(httpResponse.statusCode)")
            
            switch httpResponse.statusCode {
            case 200:
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []),
                   let dict = json as? [String: Any] {
                    print("✅ Успешный ответ: \(dict)")
                    let responseText = ((dict["choices"] as? [[String: Any]])?.first?["message"] as? [String: Any])?["content"] as? String ?? "Нет ответа"
                    completion(.success(responseText))
                } else {
                    print("❌ Ошибка парсинга JSON")
                    completion(.failure(.unknown))
                }
            case 401:
                print("❌ Ошибка 401: Неверный API-ключ")
                completion(.failure(.unauthorized))
            default:
                print("⚠️ Ошибка HTTP \(httpResponse.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                completion(.failure(.requestFailed(statusCode: httpResponse.statusCode)))
            }
        }
        print("📩 Отправка запроса в OpenAI...")
        print("🔑 Используемый API-ключ: \(apiKey)")
        print("🌐 Отправка HTTP-запроса в OpenAI API")
        task.resume()
    }
}
