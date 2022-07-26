//
//  DownloadImage.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 26.07.2022.
//

import Foundation

class DownloadImage {
    
    func getImage(stringURL: String, completion: @escaping (Data?) -> Void) {
        let url = URL(string: stringURL)
        guard let url = url else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        completion(data)
    }
}
