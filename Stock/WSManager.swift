//
//  WSManager.swift
//  Stock
//
//  Created by Андрей Парчуков on 29.03.2021.
//

import Foundation

class WSManager {
    
    static var manager = WSManager()
    private var websocketTask: URLSessionWebSocketTask?
    
    private init() {}
    
    func connect() {
        let session = URLSession(configuration: .default)
        let url = URL(string:  "wss://ws.finnhub.io?token=\(token)")!
        websocketTask = session.webSocketTask(with: url)
        
        websocketTask?.resume()
    }
    
    func send(message: String) {
        let command = URLSessionWebSocketTask.Message.string(message)
        websocketTask?.send(command) { error in
            if let error = error {
                print("WebSocket couldn’t send message because: \(error)")
            }
        }
    }
    
    func onEvent(callback: @escaping (String) -> Void) {
        receieveMessage { text in
            callback(text)
        }
    }
    
    func receieveMessage(callback: @escaping(String) -> Void) {
        websocketTask?.receive { (response) in
            switch response {
            case .success(let message) :
                switch message {
                case .string(let text):
                    callback(text)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.receieveMessage { text in
                            callback(text)
                        }
                    }
                default:
                    break
                }
            case .failure(_):
                print("Error")
            }
        }
    }
    
}
