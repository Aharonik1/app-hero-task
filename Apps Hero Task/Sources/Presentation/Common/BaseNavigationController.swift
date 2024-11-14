import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let backButtonImage = UIImage(systemName: "chevron.left")
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.mainForeground,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
        ]
        
        navigationBar.tintColor = UIColor.mainForeground
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
}
