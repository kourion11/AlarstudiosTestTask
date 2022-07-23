//
//  ViewController.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import UIKit

protocol AuthPresenterDelegate: AnyObject {
    func getUsername() -> String
    func getPassword() -> String
    func goToSecondVC()
    func presentAlert(title: String, text: String)
}

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    let networking = Networking()
    var presenter: PresenterOutputProtocol!
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textField.placeholder = "Username"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocapitalizationType = .none
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocapitalizationType = .none
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(getRequest), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        // Presenter
        presenter = AuthPresenter()
        presenter.setAuthDelegate(delegate: self)
    }
    
    @objc
    func getRequest() {
        presenter?.getStatus()
    }
    
    func setupViews() {
        view.backgroundColor = .brown
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
    }
    
    func setupConstraints() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 40)
        ])
        
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40)
        ])
    }
}

extension AuthViewController: AuthPresenterDelegate {
    func getUsername() -> String {
        return usernameTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    func goToSecondVC() {
        let vc = SecondViewController()
        present(vc, animated: true)
    }
    
    func presentAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

