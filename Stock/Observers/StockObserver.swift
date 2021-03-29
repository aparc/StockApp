//
//  Observer.swift
//  Stock
//
//  Created by Андрей Парчуков on 23.03.2021.
//

import Foundation
import Alamofire

class StockObserver: ObservableObject{
    
    @Published var stocks = [Stock]()
    @Published var selectedStockIndex: Int? = nil
    @Published var prices = [StockTimePrice]()
    private var dispatchGroup = DispatchGroup()
    
    init() {
        fetchData()
        dispatchGroup.notify(queue: DispatchQueue.main) { self.subscribe() }
    }
    
    private func fetchData() -> Void {
        let decoder = JSONDecoder()
        var parameters = ["symbol": "", "token": token]
        
        for (tiсker, companyName) in tickers {
            dispatchGroup.enter()
            parameters["symbol"] = tiсker
            AF.request("https://finnhub.io/api/v1/quote", method: .get, parameters: parameters).response { response in
                switch response.result {
                
                case let .success(result):
                    if let data = try? decoder.decode(StockQuote.self, from: result!) {
                        self.stocks.append(data.convertToStock(tiсker, companyName))
                    }
                    self.dispatchGroup.leave()

                case let .failure(error):
                    fatalError("An error occured while fetching data from API: \(error)")
                }   
            }
        }
    }
   
    private func subscribe() {
        let websocket = WSManager.manager
        websocket.connect()
        for (ticker, _) in tickers {
            websocket.send(message: "{\"type\":\"subscribe\",\"symbol\":\"\(ticker)\"}")
        }
        
        let decoder = JSONDecoder()
        websocket.onEvent { text in
            if let data = try? decoder.decode(Trades.self, from: text.data(using: .utf8)!) {
                let trades = data.data
                
                let a =  Dictionary(grouping: trades, by: {$0.s})
                for (ticker, value) in a {
                    let lastTrade =  value.max { a, b in a.t < a.t }
                    
                    let index = self.stocks.firstIndex(where: { $0.companyTicker == ticker})
                    
                    DispatchQueue.main.async {
                        self.stocks[index!].currentPrice = lastTrade?.p ?? 0.0
                        self.stocks[index!].calculateChanges()
                    }
                }
            }
        }
    }
    
}
