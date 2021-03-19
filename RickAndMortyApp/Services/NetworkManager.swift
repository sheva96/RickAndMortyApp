//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 17.03.2021.
//

import Foundation



class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(page: Int, completionHandler: @escaping (Character) -> Void) {
        let stringUrl = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard let url = URL(string: stringUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let object = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(object)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
