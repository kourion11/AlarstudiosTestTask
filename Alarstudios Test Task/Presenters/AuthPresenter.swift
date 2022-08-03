//
//  Presenter.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

protocol PresenterOutputProtocol {
    func getStatus()
}

class AuthPresenter: PresenterOutputProtocol {
    
    weak var view: AuthPresenterDelegate?
    let authRequest = AuthRequest()
    
    // MARK: - Initializers
    init(view: AuthPresenterDelegate) {
        self.view = view
    }

    // MARK: - Methods
    func getStatus() {
        let username = view?.getUsername() ?? ""
        let password = view?.getPassword() ?? ""
        authRequest.request(username: username, password: password) { [weak self] status in
            if status.status == "ok" {
                DispatchQueue.main.async {
                    self?.view?.goToSecondVC()
                }
            } else {
                DispatchQueue.main.async {
                    let error = "Неверный логин или пароль!"
                    self?.view?.presentAlert(title: "Ошибка!", text: error)
                }
            }
        }
    }
}
