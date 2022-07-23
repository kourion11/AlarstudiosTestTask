//
//  SecondPresenter.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

protocol SecondOutputPresenterProtocol {
    var elements: ElementModel? { get set }
    func setupDelegate(delegate: SecondDelegateProtocol)
    func numberOfRowsInSectionElements() -> Int
    func getCode()
}

class SecondPresenter: SecondOutputPresenterProtocol {
    
    var elements: ElementModel?
    let networking = Networking()
    
    weak var delegateView: SecondDelegateProtocol?
    
    func setupDelegate(delegate: SecondDelegateProtocol) {
        self.delegateView = delegate
    }
    
    func numberOfRowsInSectionElements() -> Int {
        return elements?.data.count ?? 0
    }
    
    func getCode() {
        networking.authRequest(username: "test", password: "123") { status in
            self.getElement(code: status.code)
        }
    }
    
    func getElement(code: String) {
        networking.getElements(code: code) { element in
            self.elements = element
            self.delegateView?.presentData()
        }
    }
}
