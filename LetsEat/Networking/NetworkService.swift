//
//  Network.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 25.01.2020.
//  Copyright © 2020 Гончаров Денис Васильевич. All rights reserved.
//

import Foundation

class NetworkService {
    
    private let session = URLSession.shared
    private let networkConfiguration: NetworkConfiguration
    private var baseUrl: URL {
        URL(string: networkConfiguration.baseUrlPath)!
    }

    init(networkConfiguration: NetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
    }
    
    func fetch<T: Codable>(endpointPath path: String, completion: @escaping (_ json: T) -> Void) {
        let baseUrlPath = networkConfiguration.baseUrlPath
        let url = URL(string: "\(baseUrlPath)/\(path)")!
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, let _ = response as? HTTPURLResponse else { return
            }
            
            do {
                debugPrint(String(bytes: data, encoding: .utf8) ?? "")
                let json = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                debugPrint(error)
            }
        }
        
        dataTask.resume()
    }
}
