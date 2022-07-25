//
//  SecondPresenter.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation

protocol SecondOutputPresenterProtocol {
    var lat: Double { get }
    var lon: Double { get }
    var elements: ElementModel? { get set }
    func setupDelegate(delegate: SecondDelegateProtocol)
    func numberOfRowsInSectionElements() -> Int
    func getCode()
    func getLonLat(indexPath: IndexPath)
}

class SecondPresenter: SecondOutputPresenterProtocol {
    var lat = 0.0
    var lon = 0.0
    
    var elements: ElementModel?
    let authRequest = AuthRequest()
    let getElements = GetElements()
    
    weak var delegateView: SecondDelegateProtocol?
    
    func setupDelegate(delegate: SecondDelegateProtocol) {
        self.delegateView = delegate
    }
    
    func numberOfRowsInSectionElements() -> Int {
        return elements?.data.count ?? 0
    }
    
    func getCode() {
        authRequest.request(username: "test", password: "123") { status in
            self.getElement(code: status.code)
        }
    }
    
    func getElement(code: String) {
        getElements.request(code: code) { element in
            self.elements = element
            self.delegateView?.presentData()
        }
    }
    
    func getLonLat(indexPath: IndexPath) {
        lat = elements?.data[indexPath.row].lat ?? 0.0
        lon = elements?.data[indexPath.row].lon ?? 0.0
    }
}
