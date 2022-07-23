//
//  AuthModel.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

struct AuthModel: Decodable {
    let status: String
    let code: String
}
