//
//  DownloadManager.swift
//  DispatchGroup
//
//  Created by Daniil MacBook Pro on 09.07.2024.
//

import Foundation

final class DownloadManager {
    func downloadImage(urlString: String, complition: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            complition(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                complition(data)
            } else {
                complition(nil)
            }
        }.resume()
    }
}
