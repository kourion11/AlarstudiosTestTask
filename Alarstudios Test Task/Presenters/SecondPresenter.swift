//
//  SecondPresenter.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import Foundation
import UIKit

protocol SecondOutputPresenterProtocol {
    var lat: Double { get }
    var lon: Double { get }
    var username: String { get set }
    var password: String { get set }
    var images: Images { get }
    var elements: ElementModel? { get set }
    func setupDelegate(delegate: SecondDelegateProtocol)
    func getImage(stringURL: String, completion: @escaping (Data?) -> Void)
    func numberOfRowsInSectionElements() -> Int
    func getCode()
    func getLonLat(indexPath: IndexPath)
}

class SecondPresenter: SecondOutputPresenterProtocol {
    
    let authRequest = AuthRequest()
    let getElements = GetElements()
    let downloadImage = DownloadImage()
    
    weak var delegateView: SecondDelegateProtocol?
    
    var elements: ElementModel?
    var images = Images()
    
    var lat = 0.0
    var lon = 0.0
    
    var username = ""
    var password = ""
    
    func setupDelegate(delegate: SecondDelegateProtocol) {
        self.delegateView = delegate
    }
    
    func numberOfRowsInSectionElements() -> Int {
        return elements?.data.count ?? 0
    }
    
    func getCode() {
        username = delegateView?.username ?? ""
        password = delegateView?.password ?? ""
        authRequest.request(username: username, password: password) { status in
            self.getElement(code: status.code)
        }
    }
    
    func getImage(stringURL: String, completion: @escaping (Data?) -> Void) {
        downloadImage.getImage(stringURL: stringURL) { data in
            DispatchQueue.main.async {
                completion(data)
            }
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
