//
//  NetworkService.swift
//  CoronaStatistics
//
//  Created by Asif Ahmed Jesi on 16/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import Foundation

class NetworkService {

    static let shared = NetworkService()
    private init() { }
    
    let headers = [
        "x-rapidapi-host": AppConstants.RAPID_API_HOST,
        "x-rapidapi-key": AppConstants.RAPID_API_KEY
    ]

    func getTotalStatistics(completion: @escaping (_ data: TotalStatistics?) -> Void) {
        
        guard let url = URL.buildTotalsUrl() else {
            completion(nil)
            return
        }
        let request = URLRequest.build(url: url, headers: headers)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion(nil)
                fatalError()
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode), let data = data else {
                completion(nil)
                fatalError()
            }
            
            let decoder = JSONDecoder()
            guard let statistics = try? decoder.decode([TotalStatistics].self, from: data) else {
                completion(nil)
                return
            }
            
            if let first = statistics.first {
                completion(first)
            }
            else {
                completion(nil)
            }
            
        }.resume()
    }
    
    func getAllCountryStatistics(completion: @escaping (_ data: [CountryStatistics]) -> Void) {
        
        guard let url = URL.buildCountryAllUrl() else {
            completion([])
            return
        }
        let request = URLRequest.build(url: url, headers: headers)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                completion([])
                fatalError()
            }
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode), let data = data else {
                completion([])
                fatalError()
            }
            
            let decoder = JSONDecoder()
            guard let list = try? decoder.decode([CountryStatistics].self, from: data) else {
                completion([])
                return
            }
            
            completion(list)
            
        }.resume()
    }

}
