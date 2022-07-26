//
//  GetElements.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 25.07.2022.
//

import Foundation

class GetElements {
    
    func request(code: String, completion: @escaping (ElementModel) -> Void) {
        var url = URLComponents(string: "https://www.alarstudios.com/test/data.cgi")
        url?.queryItems = [URLQueryItem(name: "code", value: code)]
        guard let url = url?.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONDecoder().decode(ElementModel.self, from: data)
                completion(json)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
