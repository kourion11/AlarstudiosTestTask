//
//  Networking.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

class AuthRequest {
    
    func request(username: String, password: String, completion: @escaping (AuthModel) -> Void) {
        var url = URLComponents(string: "https://www.alarstudios.com/test/auth.cgi")
        url?.queryItems = [
        URLQueryItem(name: "username", value: username),
        URLQueryItem(name: "password", value: password)
        ]
        
        guard let url = url?.url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONDecoder().decode(AuthModel.self, from: data)
                completion(json)
                print(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
