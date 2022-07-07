import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var saveChangeButton: UIButton!
    @IBOutlet private weak var blueCarImage: UIImageView!
    @IBOutlet private weak var backgroundBlueCar: UIView!
    @IBOutlet private weak var yellowCarImage: UIImageView!
    @IBOutlet private weak var backgroundYellowCar: UIView!
    @IBOutlet private weak var barrierBackgroundOne: UIView!
    @IBOutlet private weak var barrierBackgroundTwo: UIView!
    @IBOutlet private weak var barrierBackgroundThree: UIView!
    @IBOutlet private weak var imageBarrier1: UIImageView!
    @IBOutlet private weak var imageBarrier2: UIImageView!
    @IBOutlet private weak var imageBarrier3: UIImageView!
    @IBOutlet private weak var speedValue: UILabel!
    @IBOutlet private weak var sliderSpeed: UISlider!
    @IBOutlet private weak var roadBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRoad()
        showsCars()
        showBarriers()
        showChosenBarrier()
        showChosenCar()
        gesturesHandles()
        buttonDesign()
        showChosenSpeed()
    }
    
    private func showChosenSpeed() {
        if UserDefaults.standard.value(forKey: "speedCar") == nil {
            speedValue.text = "4"
        }
        else {
            if let speedInformation = UserDefaults.standard.value(forKey: "speedCar") as? String {
                speedValue.text = speedInformation
            }
        }
        
        if UserDefaults.standard.value(forKey: "positionThumb") == nil {
            sliderSpeed.value = 4
        }
        else {
            if let positionThumb = UserDefaults.standard.value(forKey: "positionThumb") as? Float {
                sliderSpeed.value = positionThumb
            }
        }
    }
    
    private func createRoad() {
        let bg = UIImage(named: "roadBG.jpg")
        roadBackground.image = bg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    private func showChosenBarrier() {
        if UserDefaults.standard.value(forKey: "barrier") == nil {
            barrierBackgroundOne.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            barrierBackgroundTwo.backgroundColor = .systemGray6
            barrierBackgroundThree.backgroundColor = .systemGray6
        }
        else {
            if UserDefaults.standard.value(forKey: "barrier") as! String == "bush" {
                barrierBackgroundOne.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
                barrierBackgroundTwo.backgroundColor = .systemGray6
                barrierBackgroundThree.backgroundColor = .systemGray6
                
            } else if UserDefaults.standard.value(forKey: "barrier") as! String == "conus" {
                barrierBackgroundOne.backgroundColor = .systemGray6
                barrierBackgroundTwo.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
                barrierBackgroundThree.backgroundColor = .systemGray6
                
            } else if UserDefaults.standard.value(forKey: "barrier") as! String == "canistra" {
                barrierBackgroundOne.backgroundColor = .systemGray6
                barrierBackgroundTwo.backgroundColor = .systemGray6
                barrierBackgroundThree.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            }
        }
    }
    
    
    private func showChosenCar() {
        if UserDefaults.standard.value(forKey: "carColor") == nil {
            backgroundBlueCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            backgroundYellowCar.backgroundColor = .systemGray6
        }
        else {
            if UserDefaults.standard.value(forKey: "carColor") as! String == "yellow" {
                backgroundBlueCar.backgroundColor = .systemGray6
                backgroundYellowCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
                
            } else if UserDefaults.standard.value(forKey: "carColor") as! String == "blue" {
                backgroundBlueCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
                backgroundYellowCar.backgroundColor = .systemGray6
            }
        }
    }
    
    private func buttonDesign() {
        saveChangeButton.setRadiusWithShadow()
    }
    
    private func gesturesHandles() {
        let tapBlueCar = UITapGestureRecognizer(target: self, action: #selector(self.handleTapBlueCar(_:)))
        blueCarImage.isUserInteractionEnabled = true
        blueCarImage.addGestureRecognizer(tapBlueCar)
        
        let tapYellowCar = UITapGestureRecognizer(target: self, action: #selector(self.handleTapYellowCar(_:)))
        yellowCarImage.isUserInteractionEnabled = true
        yellowCarImage.addGestureRecognizer(tapYellowCar)
        
        let tapBush = UITapGestureRecognizer(target: self, action: #selector(self.handleTapBush(_:)))
        imageBarrier1.isUserInteractionEnabled = true
        imageBarrier1.addGestureRecognizer(tapBush)
        
        let tapConus = UITapGestureRecognizer(target: self, action: #selector(self.handleTapConus(_:)))
        imageBarrier2.isUserInteractionEnabled = true
        imageBarrier2.addGestureRecognizer(tapConus)
        
        let tapCanistra = UITapGestureRecognizer(target: self, action: #selector(self.handleTapCanistra(_:)))
        imageBarrier3.isUserInteractionEnabled = true
        imageBarrier3.addGestureRecognizer(tapCanistra)
    }
    
    @objc func handleTapBush(_ sender: UITapGestureRecognizer? = nil) {
        barrierBackgroundOne.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        barrierBackgroundTwo.backgroundColor = .systemGray6
        barrierBackgroundThree.backgroundColor = .systemGray6
        
        UserDefaults.standard.set("bush", forKey: "barrier")
    }
    
    @objc func handleTapConus(_ sender: UITapGestureRecognizer? = nil) {
        barrierBackgroundOne.backgroundColor = .systemGray6
        barrierBackgroundTwo.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        barrierBackgroundThree.backgroundColor = .systemGray6
        
        UserDefaults.standard.set("conus", forKey: "barrier")
    }
    
    @objc func handleTapCanistra(_ sender: UITapGestureRecognizer? = nil) {
        barrierBackgroundOne.backgroundColor = .systemGray6
        barrierBackgroundTwo.backgroundColor = .systemGray6
        barrierBackgroundThree.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        
        UserDefaults.standard.set("canistra", forKey: "barrier")
    }
    
    @objc func handleTapYellowCar(_ sender: UITapGestureRecognizer? = nil) {
        backgroundBlueCar.backgroundColor = .systemGray6
        backgroundYellowCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        
        UserDefaults.standard.set("yellow", forKey: "carColor")
    }
    
    @objc func handleTapBlueCar(_ sender: UITapGestureRecognizer? = nil) {
        backgroundBlueCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        backgroundYellowCar.backgroundColor = .systemGray6
        
        UserDefaults.standard.set("blue", forKey: "carColor")
    }
    
    private func showBarriers() {
        barrierBackgroundOne.layer.cornerRadius = 10
        barrierBackgroundTwo.layer.cornerRadius = 10
        barrierBackgroundThree.layer.cornerRadius = 10
        
        let bush = UIImage(named: "item.png")
        imageBarrier1.image = bush
        imageBarrier1.contentMode = .scaleAspectFit
        self.view.addSubview(imageBarrier1)
        
        let bush2 = UIImage(named: "item2.png")
        imageBarrier2.image = bush2
        imageBarrier2.contentMode = .scaleAspectFit
        self.view.addSubview(imageBarrier2)
        
        let bush3 = UIImage(named: "item3.png")
        imageBarrier3.image = bush3
        imageBarrier3.contentMode = .scaleAspectFit
        self.view.addSubview(imageBarrier3)
    }
    
    private func showsCars() {
        backgroundBlueCar.layer.cornerRadius = 15
        backgroundYellowCar.layer.cornerRadius = 15
        
        let blueCar = UIImage(named: "myCar.png")
        blueCarImage.image = blueCar
        blueCarImage.contentMode = .scaleAspectFit
        blueCarImage.layer.shadowColor = UIColor.black.cgColor
        blueCarImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        blueCarImage.layer.shadowOpacity = 0.3
        
        self.view.addSubview(blueCarImage)
        
        let yellowCar = UIImage(named: "yellowCar.png")
        yellowCarImage.image = yellowCar
        yellowCarImage.contentMode = .scaleAspectFit
        yellowCarImage.center.x = view.center.x
        yellowCarImage.layer.shadowColor = UIColor.black.cgColor
        yellowCarImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        yellowCarImage.layer.shadowOpacity = 0.3
        
        self.view.addSubview(yellowCarImage)  
    }
    
    @IBAction func saveChangeButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(speedValue.text, forKey: "speedCar")
        UserDefaults.standard.set(sliderSpeed.value, forKey: "positionThumb")
        
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func speedSliderValue(_ sender: UISlider) {
        speedValue.text = "\(Int(sender.value))"
    }
}
