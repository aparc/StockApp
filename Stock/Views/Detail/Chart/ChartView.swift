//
//  ChartView.swift
//  Stock
//
//  Created by Андрей Парчуков on 28.03.2021.
//

import SwiftUI
import Alamofire

struct ChartView: View {
    
    // MARK: - Variables
    @EnvironmentObject var stockObserver: StockStore
    @State private var dateRange: DateInterval = DateInterval.week
    private var currentStock: Stock? {
        if let index = stockObserver.selectedStockIndex {
            return stockObserver.stocks[index]
        } else {
            return nil
        }
    }
    @State private var chartData = [StockTimePrice]()
    
    // MARK: - Body
    var body: some View {
        VStack {
            price
            
            GeometryReader { reader in
                Line(data: ChartData(values: chartData), frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width, height: reader.frame(in: .local).height + 25)))
            }
            
            TimeIntervalToggleMenu(range: $dateRange)
                .padding(.vertical, 50)
                            .onChange(of: dateRange, perform: { _ in
                                populateChartData()
                            })
            
            BuyButton(price: currentStock?.currentPrice ?? 0.0 )
        }
        .onAppear(perform: populateChartData)
        .onDisappear(perform: {
            chartData = []
        })
    }
    
    var price: some View {
        VStack {
            Text(priceToStringFormat(price: currentStock?.currentPrice ?? 0.0))
                .font(.title)
                .bold()
            Text(priceChangeToStringFormat(priceChange: currentStock?.priceChange ?? 0.0, percentChange: currentStock?.pricePercentChange ?? 0.0))
                .font(.title3)
                .foregroundColor(currentStock?.priceChange ?? 0 >= 0 ? .green : .red)
        }
    }
    
    // MARK: - Functions
    
    func populateChartData() {
        guard let stock = currentStock else {
            return
        }
        
        let cacheKey = [stock.companyTicker : dateRange]
        if let data = stockObserver.stockCache.value(forKey: cacheKey) {
            self.chartData = data
        } else {
            fetchStockData(ticker: stock.companyTicker, timeInterval: dateRange) { data in
                stockObserver.stockCache.insert(forKey: cacheKey, object: data)
                self.chartData = data
            }
        }
    }
    
    func fetchStockData(ticker: String, timeInterval: DateInterval, completion: @escaping (_ data: [StockTimePrice]) -> Void) {
        let url = "https://finnhub.io/api/v1/stock/candle"
        var parameters: [String : Any] = [
            "symbol" : ticker,
            "resolution" : 60,
            "to" : Date().timeIntervalSince1970.dropDecimal(),
            "token" : token
        ]
        switch dateRange {
        case .day:
            parameters["from"] = daysAgo(days: 1).dropDecimal()
        case .week:
            parameters["from"] = daysAgo(days: 7).dropDecimal()
        case .month:
            parameters["resolution"] = "D"
            parameters["from"] = monthsAgo(months: 1).dropDecimal()
        case .threeMonths:
            parameters["resolution"] = "W"
            parameters["from"] = monthsAgo(months: 3).dropDecimal()
        case .halfYear:
            parameters["resolution"] = "W"
            parameters["from"] = monthsAgo(months: 6).dropDecimal()
        case .year:
            parameters["resolution"] = "M"
            parameters["from"] = yearAgo().dropDecimal()
        }
        AF.request(url, method: .get, parameters: parameters).response { response in
            if let data = try? JSONDecoder().decode(StockCandleData.self, from: response.data!) {
                var prices = [StockTimePrice]()
                for index in data.h.indices {
                    prices.append(StockTimePrice(time: data.t[index], price: (data.h[index] + data.l[index] + data.c[index] + data.o[index])/4))
                }
                completion(prices)
            }
        }
    }
    
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
