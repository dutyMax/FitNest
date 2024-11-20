import UIKit

class PlanViewController: UITabBarController {
    let planNavController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressViewController = setupProgressTab()
        viewControllers = [
            setupPlanTab(),
            setupActivityTab(progressViewController: progressViewController),
            progressViewController
        ]
    }
    
    private func setupPlanTab() -> UINavigationController {
        let planInitialViewController = PlanInitialViewController()
        planInitialViewController.delegate = self
        planNavController.viewControllers = [planInitialViewController]
        planNavController.tabBarItem = UITabBarItem(title: "Plan", image: UIImage(systemName: "list.bullet"), tag: 0)
        return planNavController
    }
    
    private func setupActivityTab(progressViewController: ProgressViewController) -> UIViewController {
        let activityViewController = ActivityViewController()
        activityViewController.progressViewController = progressViewController
        activityViewController.tabBarItem = UITabBarItem(title: "Activity", image: UIImage(systemName: "figure.walk"), tag: 1)
        return activityViewController
    }
    
    private func setupProgressTab() -> ProgressViewController {
        let progressViewController = ProgressViewController()
        progressViewController.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar"), tag: 2)
        return progressViewController
    }
}

extension PlanViewController: PlanInitialViewControllerDelegate {
    func switchToPlanDone(recommendations: [[String: Any]]) {
        let planDoneViewController = PlanDoneViewController()
        planDoneViewController.delegate = self
        planDoneViewController.recommendations = recommendations
        planNavController.setViewControllers([planDoneViewController], animated: true)
    }
}

extension PlanViewController: PlanDoneViewControllerDelegate {
    func switchToPlanInitial() {
        let planInitialViewController = PlanInitialViewController()
        planInitialViewController.delegate = self
        planNavController.setViewControllers([planInitialViewController], animated: true)
    }
}


//import UIKit
//
//class PlanViewController: UITabBarController {
//    let planNavController = UINavigationController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        viewControllers = [
//            setupPlanTab(),
//            setupActivityTab(),
//            setupProgressTab()
//        ]
//    }
//
//    private func setupPlanTab() -> UINavigationController {
//        let planInitialViewController = PlanInitialViewController()
//        planInitialViewController.delegate = self
//        planNavController.viewControllers = [planInitialViewController]
//        planNavController.tabBarItem = UITabBarItem(title: "Plan", image: UIImage(systemName: "list.bullet"), tag: 0)
//        return planNavController
//    }
//
//    private func setupActivityTab() -> UIViewController {
//        let activityViewController = ActivityViewController()
//        activityViewController.tabBarItem = UITabBarItem(title: "Activity", image: UIImage(systemName: "figure.walk"), tag: 1)
//        return activityViewController
//    }
//
//    private func setupProgressTab() -> UIViewController {
//        let progressViewController = ProgressViewController()
//        progressViewController.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar"), tag: 2)
//        return progressViewController
//    }
//
//}
//
//
//extension PlanViewController: PlanInitialViewControllerDelegate {
//    func switchToPlanDone(recommendations: [[String: Any]]) {
//        let planDoneViewController = PlanDoneViewController()
//        planDoneViewController.delegate = self // Set delegate here
//        planDoneViewController.recommendations = recommendations
//        planNavController.setViewControllers([planDoneViewController], animated: true)
//    }
//}
//
//extension PlanViewController: PlanDoneViewControllerDelegate {
//    func switchToPlanInitial() {
//        let planInitialViewController = PlanInitialViewController()
//        planInitialViewController.delegate = self // Set delegate
//        planNavController.setViewControllers([planInitialViewController], animated: true)
//    }
//}
