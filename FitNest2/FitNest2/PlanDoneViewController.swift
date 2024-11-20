import UIKit

class PlanDoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: PlanDoneViewControllerDelegate?
    
    var recommendations: [[String: Any]] = [] // Store recommendations

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let editPlanButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Plan", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Recommended Workouts"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(tableView)
        view.addSubview(editPlanButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: editPlanButton.topAnchor, constant: -20),
            
            editPlanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editPlanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editPlanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editPlanButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        editPlanButton.addTarget(self, action: #selector(editPlanTapped), for: .touchUpInside)
    }

    @objc private func editPlanTapped() {
        delegate?.switchToPlanInitial()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    // bold table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let workout = recommendations[indexPath.row]

        if let title = workout["Title"] as? String,
           let desc = workout["Desc"] as? String,
           let bodyPart = workout["BodyPart"] as? String,
           let equipment = workout["Equipment"] as? String,
           let level = workout["Level"] as? String {
            
            // Create an attributed string for the formatted text
            let attributedText = NSMutableAttributedString()

            // Add each field with bold labels
            attributedText.append(boldedText(label: "Title:", value: title))
            attributedText.append(boldedText(label: "Body Part:", value: bodyPart))
            attributedText.append(boldedText(label: "Equipment:", value: equipment))
            attributedText.append(boldedText(label: "Level:", value: level))
            attributedText.append(boldedText(label: "Description:", value: desc))

            // Assign the attributed string to the cell's textLabel
            cell.textLabel?.attributedText = attributedText
        }
        
        cell.textLabel?.numberOfLines = 0 // Enable multi-line text
        return cell
    }

    // Helper method to create a bolded label with a value
    private func boldedText(label: String, value: String) -> NSAttributedString {
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 14)]
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14)]
        
        let attributedString = NSMutableAttributedString(string: label + " ", attributes: boldAttributes)
        attributedString.append(NSAttributedString(string: value + "\n", attributes: normalAttributes))
        return attributedString
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let workout = recommendations[indexPath.row]
//
//        if let title = workout["Title"] as? String,
//           let desc = workout["Desc"] as? String,
//           let bodyPart = workout["BodyPart"] as? String,
//           let equipment = workout["Equipment"] as? String,
//           let level = workout["Level"] as? String{
//            
//            cell.textLabel?.text = """
//            Title: \(title)
//            Body Part: \(bodyPart)
//            Equipment: \(equipment)
//            Level: \(level)
//            Desc: \(desc)
//            """
//        }
//        cell.textLabel?.numberOfLines = 0 // Enable multi-line text
//        return cell
//    }
}

protocol PlanDoneViewControllerDelegate: AnyObject {
    func switchToPlanInitial()
}



//import UIKit
//
//class PlanDoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    var recommendations: [[String: Any]] = [] // Store recommendations
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Recommended Workouts"
//
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        view.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return recommendations.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let workout = recommendations[indexPath.row]
//
//        if let title = workout["Title"] as? String,
//           let desc = workout["Desc"] as? String,
//           let bodyPart = workout["BodyPart"] as? String,
//           let equipment = workout["Equipment"] as? String,
//           let level = workout["Level"] as? String,
//           let score = workout["Score"] as? Double {
//            
//            cell.textLabel?.text = """
//            Title: \(title)
//            Desc: \(desc)
//            BodyPart: \(bodyPart)
//            Equipment: \(equipment)
//            Level: \(level)
//            Score: \(String(format: "%.2f", score))
//            """
//        }
//        cell.textLabel?.numberOfLines = 0 // Enable multi-line text
//        return cell
//    }
//}



//
////
////  PlanDoneViewController.swift
////  FitNest2
////
////  Created by Maximiliano Pombo on 11/18/24.
////
//import UIKit
//
//protocol PlanDoneViewControllerDelegate: AnyObject {
//    func switchToPlanInitial()
//}
//
//class PlanDoneViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    weak var delegate: PlanDoneViewControllerDelegate?
//    
//    // Dummy data for the table
//    let exercises = [
//        ["Exercise": "Crunches", "Body Part": "Abdominals", "Equipment": "Nothing", "Sets": "3x10"],
//        ["Exercise": "Plank", "Body Part": "Abdominals", "Equipment": "Nothing", "Sets": "3x50s"],
//        ["Exercise": "Leg Raises", "Body Part": "Abdominals", "Equipment": "Bar", "Sets": "3x8"],
//        ["Exercise": "Squats", "Body Part": "Legs", "Equipment": "Nothing", "Sets": "3x12"],
//        ["Exercise": "Lunges", "Body Part": "Legs", "Equipment": "Nothing", "Sets": "3x12"]
//    ]
//    
//    // UI Components
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Your Plan"
//        label.font = UIFont.boldSystemFont(ofSize: 28)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//    
//    private let editPlanButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Edit Plan", for: .normal)
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
//        // Set up TableView
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        
//        // Add subviews
//        view.addSubview(titleLabel)
//        view.addSubview(tableView)
//        view.addSubview(editPlanButton)
//        
//        // Layout
//        NSLayoutConstraint.activate([
//            // Title Label
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            // Table View
//            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            tableView.bottomAnchor.constraint(equalTo: editPlanButton.topAnchor, constant: -20),
//            
//            // Edit Plan Button
//            editPlanButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            editPlanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            editPlanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            editPlanButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        // Add button action
//        editPlanButton.addTarget(self, action: #selector(editPlanTapped), for: .touchUpInside)
//    }
//    
//    // MARK: - UITableViewDataSource Methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return exercises.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let exercise = exercises[indexPath.row]
//        
//        // Format the exercise details
//        let exerciseDetails = """
//        Exercise: \(exercise["Exercise"] ?? "")
//        Body Part: \(exercise["Body Part"] ?? "")
//        Equipment: \(exercise["Equipment"] ?? "")
//        Sets: \(exercise["Sets"] ?? "")
//        """
//        cell.textLabel?.text = exerciseDetails
//        cell.textLabel?.numberOfLines = 0 // Allow multi-line text
//        return cell
//    }
//    
//    // MARK: - Button Action
//    @objc func editPlanTapped() {
//        delegate?.switchToPlanInitial()
//    }
//}
//
//
