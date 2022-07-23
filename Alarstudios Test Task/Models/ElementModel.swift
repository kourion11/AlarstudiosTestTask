//
//  Element.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

// MARK: - Model
struct ElementModel: Decodable {
    let status: String
    let page: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Decodable {
    let id, name: String
    let country: Country
    let lat, lon: Double
}

enum Country: String, Decodable {
    case unitedStatesOfAmerica = "United States of America"
}
