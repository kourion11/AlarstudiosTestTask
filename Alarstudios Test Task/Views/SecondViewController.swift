//
//  SecondViewController.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import UIKit

protocol SecondDelegateProtocol: AnyObject {
    func presentData()
}

class SecondViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    private var presenter: SecondOutputPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getCode()
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func setPresenter(_ presenter: SecondOutputPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setupTable() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSectionElements()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = presenter?.elements?.data[indexPath.row]
        let imagesURL = presenter.images.imagesURL[indexPath.row]
        presenter.getImage(stringURL: imagesURL) { image in
            guard let image = image else { return }
            cell.textLabel?.text = model?.name
            cell.imageView?.image = UIImage(data: image)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.getLonLat(indexPath: indexPath)
        let mapVC = MapViewController()
        mapVC.lat = presenter.lat
        mapVC.lon = presenter.lon
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension SecondViewController: SecondDelegateProtocol {
    func presentData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
