import UIKit

protocol PlanInitialViewControllerDelegate: AnyObject {
    func switchToPlanDone(recommendations: [[String: Any]])
}

class PlanInitialViewController: UIViewController {
    weak var delegate: PlanInitialViewControllerDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's get to know you!"
        label.font = UIFont.boldSystemFont(ofSize: 28) // Larger font size
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let promptLabel: UILabel = {
        let label = UILabel()
        label.text = "What are your fitness goals?"
        label.font = UIFont.systemFont(ofSize: 18) // Larger font size
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let goalsTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8
        textView.text = ""
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let createPlanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Plan", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

//    private let goalsTextView: UITextView = {
//        let textView = UITextView()
//        textView.layer.borderColor = UIColor.gray.cgColor
//        textView.layer.borderWidth = 1.0
//        textView.layer.cornerRadius = 8.0
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }()
//
//    private let createPlanButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Create Plan", for: .normal)
//        button.backgroundColor = UIColor.systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        title = "Let's get to know you!"

        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(promptLabel)
        view.addSubview(goalsTextView)
        view.addSubview(createPlanButton)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
        
            // Prompt Label
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            promptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        
            // Goals Text View
            goalsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goalsTextView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
            goalsTextView.widthAnchor.constraint(equalToConstant: 300),
            goalsTextView.heightAnchor.constraint(equalToConstant: 150), // Larger height
    
            // Create Plan Button
            createPlanButton.topAnchor.constraint(equalTo: goalsTextView.bottomAnchor, constant: 30),
            createPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createPlanButton.widthAnchor.constraint(equalToConstant: 300),
            createPlanButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add button action
        createPlanButton.addTarget(self, action: #selector(createPlanTapped), for: .touchUpInside)

//        // Set up constraints
//        NSLayoutConstraint.activate([
//            goalsTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            goalsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            goalsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            goalsTextView.heightAnchor.constraint(equalToConstant: 150),
//
//            createPlanButton.topAnchor.constraint(equalTo: goalsTextView.bottomAnchor, constant: 20),
//            createPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            createPlanButton.widthAnchor.constraint(equalToConstant: 200),
//            createPlanButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//
//        createPlanButton.addTarget(self, action: #selector(createPlanTapped), for: .touchUpInside)
    }

    @objc private func createPlanTapped() {
        guard let goals = goalsTextView.text, !goals.isEmpty else {
            showAlert(message: "Please enter your fitness goals.")
            return
        }

        // Fetch recommendations from the Flask API
        fetchRecommendations(query: goals) { recommendations in
            DispatchQueue.main.async {
                self.delegate?.switchToPlanDone(recommendations: recommendations)
            }
        }
    }

    private func fetchRecommendations(query: String, completion: @escaping ([[String: Any]]) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5001/recommendations") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonBody: [String: Any] = ["query": query]
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching recommendations: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let recommendations = json["recommendations"] as? [[String: Any]] {
                completion(recommendations)
            } else {
                print("Error parsing response")
                completion([])
            }
        }.resume()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


////
////  PlanInitialViewController.swift
////  FitNest2
////
////  Created by Maximiliano Pombo on 11/18/24.
////
//import UIKit
//import PythonKit
//
//protocol PlanInitialViewControllerDelegate: AnyObject {
//    func switchToPlanDone()
//}
//
////protocol PlanInitialViewControllerDelegate: AnyObject {
////    func switchToPlanDone(recommendations: [[String: Any]])
////}
//
//class PlanInitialViewController: UIViewController {
//    
//    weak var delegate: PlanInitialViewControllerDelegate?
//    
//    // UI Components
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Let's get to know you!"
//        label.font = UIFont.boldSystemFont(ofSize: 28) // Larger font size
//        label.textColor = .black
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let promptLabel: UILabel = {
//        let label = UILabel()
//        label.text = "What are your fitness goals?"
//        label.font = UIFont.systemFont(ofSize: 18) // Larger font size
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let goalsTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        textView.layer.cornerRadius = 8
//        textView.text = ""
//        textView.isScrollEnabled = true
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }()
//    
//    private let createPlanButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Create Plan", for: .normal)
//        button.backgroundColor = UIColor.systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        // Add subviews
//        view.addSubview(titleLabel)
//        view.addSubview(promptLabel)
//        view.addSubview(goalsTextView)
//        view.addSubview(createPlanButton)
//        
//        // Set up constraints
//        NSLayoutConstraint.activate([
//            // Title Label
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
//            
//            // Prompt Label
//            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            promptLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            
//            // Goals Text View
//            goalsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            goalsTextView.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: 20),
//            goalsTextView.widthAnchor.constraint(equalToConstant: 300),
//            goalsTextView.heightAnchor.constraint(equalToConstant: 150), // Larger height
//            
//            // Create Plan Button
//            createPlanButton.topAnchor.constraint(equalTo: goalsTextView.bottomAnchor, constant: 30),
//            createPlanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            createPlanButton.widthAnchor.constraint(equalToConstant: 300),
//            createPlanButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        // Add button action
//        createPlanButton.addTarget(self, action: #selector(createPlanTapped), for: .touchUpInside)
//    }
//    
//    @objc func createPlanTapped() {
//        guard let goals = goalsTextView.text, !goals.isEmpty else {
//            showAlert(message: "Please enter your fitness goals.")
//            return
//        }
//        print("User's goals: \(goals)") // Debug log
//        delegate?.switchToPlanDone()
//    }
////    @objc func createPlanTapped() {
////        guard let goals = goalsTextView.text, !goals.isEmpty else {
////            showAlert(message: "Please enter your fitness goals.")
////            return
////        }
////            
////        // Call the Python function and pass results to the delegate
////        getWorkoutRecommendations(query: goals) { recommendations in
////            DispatchQueue.main.async {
////                self.delegate?.switchToPlanDone(recommendations: recommendations)
////            }
////        }
////    }
//    
//    private func getWorkoutRecommendations(query: String, completion: @escaping ([[String: Any]]) -> Void) {
//        DispatchQueue.global().async {
//            // Import PythonKit
//                    
//            // Set the Python environment
//            let sys = Python.import("sys")
//            sys.path.append(Bundle.main.bundlePath + "/PythonScripts")
//                
//            // Import the main script
//            let main = Python.import("main")
//                
//            // Call the Python function and parse results
//            let recommendations = main.get_workout_recommendations(query)
//            let parsedRecommendations = recommendations.map { rec in
//                [
//                    "Title": rec["Title"] ?? "",
//                    "Score": rec["Score"] ?? 0.0
//                ]
//            }
//            
//            completion(parsedRecommendations)
//        }
//    }
//    
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        present(alert, animated: true)
//    }
//}
//
