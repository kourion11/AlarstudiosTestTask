//
//  Presenter.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

protocol PresenterOutputProtocol {
    func getStatus()
    func setAuthDelegate(delegate: AuthPresenterDelegate)
}

class AuthPresenter: PresenterOutputProtocol {
    
    weak var delegateView: AuthPresenterDelegate?
    let networking = Networking()
    
    func getStatus() {
        let username = delegateView?.getUsername() ?? ""
        let password = delegateView?.getPassword() ?? ""
        networking.authRequest(username: username, password: password) { [weak self] status in
            if status.status == "ok" {
                DispatchQueue.main.async {
                    self?.delegateView?.goToSecondVC()
                }
            } else {
                DispatchQueue.main.async {
                    let error = "Неправильный логин или пароль"
                    self?.delegateView?.presentAlert(title: "Ошибка", text: error)
                }
            }
        }
    }
    
    func setAuthDelegate(delegate: AuthPresenterDelegate) {
        self.delegateView = delegate
    }
}
