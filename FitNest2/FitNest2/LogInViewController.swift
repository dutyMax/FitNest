//
//  LogInViewController.swift
//  FitNest
//

import UIKit

class LogInViewController: UIViewController {
    
    // UI Components
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "FitNest"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let motivationalLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Fitness Journey Starts Here"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add components
        [titleLabel, motivationalLabel, emailTextField, passwordTextField, loginButton, signUpButton].forEach { view.addSubview($0) }
        
        // Layout
        NSLayoutConstraint.activate([
            // Title label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Motivational label
            motivationalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            motivationalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Email text field
            emailTextField.topAnchor.constraint(equalTo: motivationalLabel.bottomAnchor, constant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            
            // Password text field
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            // Log In button
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Sign Up button
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Add actions
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {
        // Check if email or password fields are empty
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        
        // Navigate to PlanViewController
        let planViewController = PlanViewController()
        planViewController.modalPresentationStyle = .fullScreen
        present(planViewController, animated: true, completion: nil)
    }
    
    @objc private func handleSignUp() {
        // Placeholder for sign-up functionality
        print("Sign Up button tapped")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


////
////  LogInViewController.swift
////  FitNest
////
//
//import UIKit
//
//class LogInViewController: UIViewController {
//    
//    // UI Components
//    let emailTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Email"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//    
//    let passwordTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Password"
//        textField.borderStyle = .roundedRect
//        textField.isSecureTextEntry = true
//        return textField
//    }()
//    
//    let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Log In", for: .normal)
//        button.backgroundColor = UIColor.systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        // Add components
//        [emailTextField, passwordTextField, loginButton].forEach { view.addSubview($0) }
//        
//        // Layout
//        emailTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
//        loginButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
//            emailTextField.widthAnchor.constraint(equalToConstant: 300),
//            
//            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
//            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
//            
//            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
//            loginButton.widthAnchor.constraint(equalToConstant: 300),
//            loginButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    @objc private func handleLogin() {
//        // Navigate to PlanViewController
//        let planViewController = PlanViewController()
//        planViewController.modalPresentationStyle = .fullScreen
//        present(planViewController, animated: true, completion: nil)
//    }
//}
