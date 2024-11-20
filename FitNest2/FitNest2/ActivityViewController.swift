import UIKit

class ActivityViewController: UIViewController {
    
    // Timer-related properties
    private var timer: Timer?
    private var secondsElapsed: Int = 0
    private var isPaused: Bool = true
    
    // Reference to ProgressViewController
    weak var progressViewController: ProgressViewController?
    
    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's get Active!"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 66)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let beginActivityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Begin Activity", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pauseResumeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pause Timer", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private let finishActivityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Finish Activity", for: .normal)
        button.backgroundColor = UIColor.systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(timerLabel)
        view.addSubview(beginActivityButton)
        view.addSubview(pauseResumeButton)
        view.addSubview(finishActivityButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            beginActivityButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
            beginActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beginActivityButton.widthAnchor.constraint(equalToConstant: 200),
            beginActivityButton.heightAnchor.constraint(equalToConstant: 50),
            
            pauseResumeButton.topAnchor.constraint(equalTo: beginActivityButton.bottomAnchor, constant: 20),
            pauseResumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseResumeButton.widthAnchor.constraint(equalToConstant: 200),
            pauseResumeButton.heightAnchor.constraint(equalToConstant: 50),
            
            finishActivityButton.topAnchor.constraint(equalTo: pauseResumeButton.bottomAnchor, constant: 20),
            finishActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishActivityButton.widthAnchor.constraint(equalToConstant: 200),
            finishActivityButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Button actions
        beginActivityButton.addTarget(self, action: #selector(startActivity), for: .touchUpInside)
        pauseResumeButton.addTarget(self, action: #selector(togglePauseResume), for: .touchUpInside)
        finishActivityButton.addTarget(self, action: #selector(finishActivity), for: .touchUpInside)
    }
    
    @objc private func startActivity() {
        beginActivityButton.isHidden = true
        pauseResumeButton.isHidden = false
        finishActivityButton.isHidden = false
        isPaused = false
        startTimer()
    }
    
    @objc private func togglePauseResume() {
        if isPaused {
            pauseResumeButton.setTitle("Pause Timer", for: .normal)
            isPaused = false
            startTimer()
        } else {
            pauseResumeButton.setTitle("Resume Activity", for: .normal)
            isPaused = true
            timer?.invalidate()
        }
    }
    
//    @objc private func finishActivity() {
//        guard isPaused else { return } // Only allow when paused
//        
//        timer?.invalidate()
//        let duration = String(format: "%.2f", Double(secondsElapsed) / 60.0) // Convert to minutes
//        secondsElapsed = 0
//        timerLabel.text = "00:00"
//        isPaused = true
//        beginActivityButton.isHidden = false
//        pauseResumeButton.isHidden = true
//        finishActivityButton.isHidden = true
//        pauseResumeButton.setTitle("Pause Timer", for: .normal)
//        
//        // Add progress to ProgressViewController
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yy"
//        let date = dateFormatter.string(from: Date())
//        progressViewController?.addProgress(date: date, duration: duration)
//    }
    @objc private func finishActivity() {
        guard isPaused else { return } // Only allow finishing when paused
        
        // Calculate the duration in minutes and seconds
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        let duration = String(format: "%02d:%02d", minutes, seconds) // Format as MM:SS
        
        // Get the current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        let date = dateFormatter.string(from: Date())
        
        // Add progress to ProgressViewController
        progressViewController?.addProgress(date: date, duration: duration)
        
        // Reset the timer and UI
        timer?.invalidate()
        secondsElapsed = 0
        timerLabel.text = "00:00"
        isPaused = true

        // Reset button visibility
        beginActivityButton.isHidden = false
        pauseResumeButton.isHidden = true
        finishActivityButton.isHidden = true
        pauseResumeButton.setTitle("Pause Timer", for: .normal)
    }


    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.secondsElapsed += 1
            self.updateTimerLabel()
        }
    }
    
    private func updateTimerLabel() {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
}


////
////  ActivityViewController.swift
////  FitNest2
////
////  Created by Maximiliano Pombo on 11/18/24.
////
//
//import UIKit
//
//class ActivityViewController: UIViewController {
//    
//    // Timer-related properties
//    private var timer: Timer?
//    private var secondsElapsed: Int = 0
//    private var isPaused: Bool = true
//
//    // UI Components
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Let's get Active!"
//        label.font = UIFont.boldSystemFont(ofSize: 28)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let timerLabel: UILabel = {
//        let label = UILabel()
//        label.text = "00:00"
//        label.font = UIFont.boldSystemFont(ofSize: 66)
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let beginActivityButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Begin Activity", for: .normal)
//        button.backgroundColor = UIColor.systemGreen
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    private let pauseResumeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Pause Timer", for: .normal)
//        button.backgroundColor = UIColor.systemBlue
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isHidden = true // Hidden until activity starts
//        return button
//    }()
//    
//    private let finishActivityButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Finish Activity", for: .normal)
//        button.backgroundColor = UIColor.systemRed
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 10
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.isHidden = true // Hidden until activity starts
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
////        title = "Let's get Active!"
//        
//        // Add subviews
//        view.addSubview(titleLabel)
//        view.addSubview(timerLabel)
//        view.addSubview(beginActivityButton)
//        view.addSubview(pauseResumeButton)
//        view.addSubview(finishActivityButton)
//        
//        // Layout constraints
//        NSLayoutConstraint.activate([
//            // Title Label
//            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            // Timer Label
//            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100), // Center the timer above the buttons
//            
//            // Begin Activity Button
//            beginActivityButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 40),
//            beginActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            beginActivityButton.widthAnchor.constraint(equalToConstant: 200),
//            beginActivityButton.heightAnchor.constraint(equalToConstant: 50),
//            
//            // Pause/Resume Button
//            pauseResumeButton.topAnchor.constraint(equalTo: beginActivityButton.bottomAnchor, constant: 20),
//            pauseResumeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pauseResumeButton.widthAnchor.constraint(equalToConstant: 200),
//            pauseResumeButton.heightAnchor.constraint(equalToConstant: 50),
//            
//            // Finish Activity Button
//            finishActivityButton.topAnchor.constraint(equalTo: pauseResumeButton.bottomAnchor, constant: 20),
//            finishActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            finishActivityButton.widthAnchor.constraint(equalToConstant: 200),
//            finishActivityButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        
//        // Add button actions
//        beginActivityButton.addTarget(self, action: #selector(startActivity), for: .touchUpInside)
//        pauseResumeButton.addTarget(self, action: #selector(togglePauseResume), for: .touchUpInside)
//        finishActivityButton.addTarget(self, action: #selector(finishActivity), for: .touchUpInside)
//    }
//    
//    // MARK: - Button Actions
//    @objc private func startActivity() {
//        // Show timer-related buttons and hide "Begin Activity"
//        beginActivityButton.isHidden = true
//        pauseResumeButton.isHidden = false
//        finishActivityButton.isHidden = false
//        
//        // Start the timer
//        isPaused = false
//        startTimer()
//    }
//    
//    @objc private func togglePauseResume() {
//        if isPaused {
//            // Resume the timer
//            pauseResumeButton.setTitle("Pause Timer", for: .normal)
//            isPaused = false
//            startTimer()
//        } else {
//            // Pause the timer
//            pauseResumeButton.setTitle("Resume Activity", for: .normal)
//            isPaused = true
//            timer?.invalidate()
//        }
//    }
//    
//    @objc private func finishActivity() {
//        guard isPaused else { return } // Only allow when paused
//        
//        // Reset timer and UI
//        timer?.invalidate()
//        secondsElapsed = 0
//        timerLabel.text = "00:00"
//        isPaused = true
//        
//        // Hide timer-related buttons and show "Begin Activity"
//        beginActivityButton.isHidden = false
//        pauseResumeButton.isHidden = true
//        finishActivityButton.isHidden = true
//        
//        pauseResumeButton.setTitle("Pause Timer", for: .normal)
//    }
//    
//    // MARK: - Timer Management
//    private func startTimer() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            self.secondsElapsed += 1
//            self.updateTimerLabel()
//        }
//    }
//    
//    private func updateTimerLabel() {
//        let minutes = secondsElapsed / 60
//        let seconds = secondsElapsed % 60
//        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
//    }
//}
//
