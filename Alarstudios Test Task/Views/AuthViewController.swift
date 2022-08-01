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

class AuthViewController: UIViewController {
    
    private var presenter: PresenterOutputProtocol!
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
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
        let textField = UITextField()
        textField.placeholder = "Пароль"
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
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(getRequest), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setPresenter(_ presenter: PresenterOutputProtocol) {
        self.presenter = presenter
    }
    
    @objc
    func getRequest() {
        presenter?.getStatus()
    }
    
    func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
    }
    
    func setupConstraints() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: usernameTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300)
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
        let presenter = SecondPresenter(view: vc, username: getUsername(), password: getPassword())
        vc.setPresenter(presenter)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            getRequest()
        }
        return true
    }
}

