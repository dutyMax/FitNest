import UIKit

class ProgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var progressData = [
        ["Date": "10/31/24", "Duration": "30:21"],
        ["Date": "11/2/24", "Duration": "12:59"],
        ["Date": "11/5/24", "Duration": "15:45"]
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Progress"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func addProgress(date: String, duration: String) {
        progressData.append(["Date": date, "Duration": duration])
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = progressData[indexPath.row]
        cell.textLabel?.text = "Date: \(row["Date"] ?? "") | Duration: \(row["Duration"] ?? "")"
        return cell
    }
}


////
////  ProgressViewController.swift
////  FitNest2
////
////  Created by Maximiliano Pombo on 11/18/24.
////
//
//import UIKit
//
//class ProgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    // Dummy data for the table
//    let progressData = [
//        ["Date": "10/31/24", "Duration": "30.00"],
//        ["Date": "11/2/24", "Duration": "59"],
//        ["Date": "11/5/24", "Duration": "45"]
//    ]
//    
//    // UI Components
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Progress"
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
//        
//        // Layout constraints
//        NSLayoutConstraint.activate([
//            // Title Label
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            // Table View
//            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//    }
//    
//    // MARK: - UITableViewDataSource Methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return progressData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let row = progressData[indexPath.row]
//        
//        // Format the row data
//        let rowDetails = "Date: \(row["Date"] ?? "") | Duration: \(row["Duration"] ?? "")"
//        cell.textLabel?.text = rowDetails
//        cell.textLabel?.numberOfLines = 0 // Allow multi-line text
//        return cell
//    }
//    
//    // MARK: - UITableViewDelegate Methods (Optional)
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        print("Selected Date: \(progressData[indexPath.row]["Date"] ?? "")")
//    }
//}
