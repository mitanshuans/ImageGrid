//
//  Networking.swift
//  ImageGrid
//
//  Created by ajm2021 on 19/04/24.
//

import Foundation
class Networking {
    static let shared = Networking()

    let apiUrl = "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100"
    
    func apiCall(completion: @escaping ([DataModal]?) -> Void) {
        guard let url = URL(string: apiUrl) else {
            print("Invalid API URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching images: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode([DataModal].self, from: data)
                completion(response)
            } catch {
                print("Error decoding images response: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
