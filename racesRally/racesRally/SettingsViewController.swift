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
    @IBOutlet private weak var backgroundControlButtons: UIView!
    @IBOutlet private weak var backgroundControlAccelerometer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRoad()
        showsCars()
        
        showBarriers(name: "item.png", imageBarrier: imageBarrier1)
        showBarriers(name: "item2.png", imageBarrier: imageBarrier2)
        showBarriers(name: "item3.png", imageBarrier: imageBarrier3)
        
        barrierBackgroundOne.layer.cornerRadius = 10
        barrierBackgroundTwo.layer.cornerRadius = 10
        barrierBackgroundThree.layer.cornerRadius = 10
        
        backgroundControlButtons.layer.cornerRadius = 10
        backgroundControlAccelerometer.layer.cornerRadius = 10
       
        showChosenBarrier()
        showChosenCar()
        showChosenControl()
        gesturesHandles()
        saveButtonDesign()
        showChosenSpeed()
    }
    
    private func showChosenSpeed() {
        if UserDefaults.standard.value(forKey: "speedCar") == nil {
            speedValue.text = "4"
        } else {
            if let speedInformation = UserDefaults.standard.value(forKey: "speedCar") as? String {
                speedValue.text = speedInformation
            }
        }
        
        if UserDefaults.standard.value(forKey: "positionThumb") == nil {
            sliderSpeed.value = 4
        } else {
            if let positionThumb = UserDefaults.standard.value(forKey: "positionThumb") as? Float {
                sliderSpeed.value = positionThumb
            }
        }
    }
    
    private func createRoad() {
        let roadBg = UIImage(named: "roadBG.jpg")
        roadBackground.image = roadBg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    private func showChosenBarrier() {
        switch UserDefaults.standard.value(forKey: "barrier") as? String {
        case "bush":
            barrierBackgroundOne.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            barrierBackgroundTwo.backgroundColor = .systemGray6
            barrierBackgroundThree.backgroundColor = .systemGray6
        case "conus":
            barrierBackgroundOne.backgroundColor = .systemGray6
            barrierBackgroundTwo.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            barrierBackgroundThree.backgroundColor = .systemGray6
        case "canistra":
            barrierBackgroundOne.backgroundColor = .systemGray6
            barrierBackgroundTwo.backgroundColor = .systemGray6
            barrierBackgroundThree.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        default:
            barrierBackgroundOne.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            barrierBackgroundTwo.backgroundColor = .systemGray6
            barrierBackgroundThree.backgroundColor = .systemGray6
        }
    }
    
    private func showChosenCar() {
        switch UserDefaults.standard.value(forKey: "carColor") as? String {
        case "yellow":
            backgroundBlueCar.backgroundColor = .systemGray6
            backgroundYellowCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        case "blue":
            backgroundBlueCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            backgroundYellowCar.backgroundColor = .systemGray6
        default:
            backgroundBlueCar.backgroundColor = .systemGray6
            backgroundYellowCar.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        }
    }
    
    private func showChosenControl() {
        switch UserDefaults.standard.value(forKey: "control") as? String {
        case "buttons":
            backgroundControlButtons.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            backgroundControlAccelerometer.backgroundColor = .systemGray6
        case "accelerometer":
            backgroundControlButtons.backgroundColor = .systemGray6
            backgroundControlAccelerometer.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        default:
            backgroundControlButtons.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
            backgroundControlAccelerometer.backgroundColor = .systemGray6
        }
    }
    
    private func saveButtonDesign() {
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
        
        let tapButtons = UITapGestureRecognizer(target: self, action: #selector(self.handleTapButtons(_:)))
        backgroundControlButtons.isUserInteractionEnabled = true
        backgroundControlButtons.addGestureRecognizer(tapButtons)
        
        let tapAccelerometer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAccelerometer(_:)))
        backgroundControlAccelerometer.isUserInteractionEnabled = true
        backgroundControlAccelerometer.addGestureRecognizer(tapAccelerometer)
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
    
    @objc func handleTapButtons(_ sender: UITapGestureRecognizer? = nil) {
        backgroundControlButtons.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)
        backgroundControlAccelerometer.backgroundColor = .systemGray6

        UserDefaults.standard.set("buttons", forKey: "control")
    }
    
    @objc func handleTapAccelerometer(_ sender: UITapGestureRecognizer? = nil) {
        backgroundControlButtons.backgroundColor = .systemGray6
        backgroundControlAccelerometer.backgroundColor = UIColor(red: 209/255, green: 210/255, blue: 168/255, alpha: 1.0)

        UserDefaults.standard.set("accelerometer", forKey: "control")
    }
    
    private func showBarriers(name: String, imageBarrier: UIImageView) {
        let barrier = UIImage(named: name)
        imageBarrier.image = barrier
        imageBarrier.contentMode = .scaleAspectFit
        self.view.addSubview(imageBarrier)
    }
    
    private func showsCars() {
        backgroundBlueCar.layer.cornerRadius = 15
        backgroundYellowCar.layer.cornerRadius = 15
        
        initialCars(name: "blueCar.png", carImage: blueCarImage)
        initialCars(name: "yellowCar.png", carImage: yellowCarImage)
    }
    
    private func initialCars(name: String, carImage: UIImageView) {
        let myCar = UIImage(named: name)
    
        carImage.image = myCar
        carImage.contentMode = .scaleAspectFit
        carImage.layer.shadowColor = UIColor.black.cgColor
        carImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        carImage.layer.shadowOpacity = 0.3
        
        self.view.addSubview(carImage)
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
