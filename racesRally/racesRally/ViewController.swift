import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var startGameButton: UIButton!
    @IBOutlet private weak var recordsButton: UIButton!
    @IBOutlet private weak var settingButton: UIButton!
    @IBOutlet private weak var mainImageBG: UIImageView!
    @IBOutlet private weak var titleRacesRally: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        mainImage()
        racesRallyText()
        buttonsSettings()
    }
    
    private func buttonsSettings() {
        startGameButton.setTitle("START", for: .normal)
        recordsButton.setTitle("RECORDS", for: .normal)
        settingButton.setTitle("SETTINGS", for: .normal)
        
        startGameButton.setRadiusWithShadow()
        recordsButton.setRadiusWithShadow()
        settingButton.setRadiusWithShadow()
    }
    
    private func racesRallyText() {
        let text = "RACES RALLY"
        let attrString = NSMutableAttributedString(string: text, attributes: [:])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineHeightMultiple = 0.80
       
        attrString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attrString.length))
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
       
        titleRacesRally.attributedText = attrString
        titleRacesRally.numberOfLines = 0
        titleRacesRally.font = UIFont(name: "Boogaloo-Regular", size: 90)
    }
    
    private func mainImage() {
        let image = UIImage(named: "mainScreen.png")
        mainImageBG.image = image
        mainImageBG.center.x = view.center.x
        
        self.view.sendSubviewToBack(mainImageBG)
    }
    
    @IBAction func startGameButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let gameController = storyboard.instantiateViewController(identifier: "GameViewController") as? GameViewController {
            gameController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(gameController, animated: false)
        }
    }
    
    @IBAction func showRecordsButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let recordsViewController = storyboard.instantiateViewController(identifier: "RecordsViewController") as? RecordsViewController {
            recordsViewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(recordsViewController, animated: false)
        }
    }
    
    @IBAction func setingsGameButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let settingsController = storyboard.instantiateViewController(identifier: "SettingsViewController") as? SettingsViewController {
            settingsController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(settingsController, animated: false)
        }
    }
}
