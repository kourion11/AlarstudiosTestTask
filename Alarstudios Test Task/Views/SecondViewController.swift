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
    
    var presenter: SecondOutputPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SecondPresenter()
        presenter?.setupDelegate(delegate: self)
        
        presenter?.getCode()
        setupTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func setupTable() {
        view.backgroundColor = .red
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
        cell.textLabel?.text = model?.name
        return cell
    }
}

extension SecondViewController: SecondDelegateProtocol {
    func presentData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
