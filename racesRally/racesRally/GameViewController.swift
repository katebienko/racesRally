import UIKit
import AVKit
import CoreMotion

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isGameOver: Bool = false
    var index = 0
    var linesArray: [UIView] = [UIView()]
    var speedBarrier: Double = 0.00
    var result: Int = 0
    var player: AVAudioPlayer?
    var motion = CMMotionManager()
    
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var barrierImageView: UIImageView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var roadBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLines(pointX: 125)
        createLines(pointX: Int(self.view.frame.maxX) - 125)
        
        audioSoung()
        createBackground()
        buttonsDesign()
        setCar()
        setBarrier()
        longPressGestiresRecognizersButtons()
    }
    
    private func audioSoung() {
        if let audioURL = Bundle.main.url(forResource: "car", withExtension: "mp3") {
            self.player = try? AVAudioPlayer(contentsOf: audioURL)
            player?.play()
        }
    }
    
    private func createBackground() {
        let roadBg = UIImage(named: "roadBG.jpg")
        roadBackground.image = roadBg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    private func longPressGestiresRecognizersButtons() {
        let pressRightButton = UILongPressGestureRecognizer(target: self, action: #selector(longPressRight))
        pressRightButton.minimumPressDuration = 0
        rightButton.addGestureRecognizer(pressRightButton)
        
        let pressLeftButton = UILongPressGestureRecognizer(target: self, action: #selector(longPressLeft))
        pressLeftButton.minimumPressDuration = 0
        leftButton.addGestureRecognizer(pressLeftButton)
    }
    
    @objc func longPressRight(gestureReconizer: UILongPressGestureRecognizer) {
        carImageView.transform = CGAffineTransform(rotationAngle: 0.10)

            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
                if self.view.frame.width + 10 <= self.carImageView.frame.maxX {
                    timer.invalidate()
                    self.isGameOver = true
                    self.player?.stop()
                    self.navigationController?.popToRootViewController(animated: false)
                }
                
                self.carImageView.center.x += 10
                
                if gestureReconizer.state != UIGestureRecognizer.State.began {
                    self.carImageView.transform = CGAffineTransform(rotationAngle: 0)
                    timer.invalidate()
                }
            })
    }
    
    @objc func longPressLeft(gestureReconizer: UILongPressGestureRecognizer) {
        carImageView.transform = CGAffineTransform(rotationAngle: -0.10)

            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { timer in
                if self.view.frame.origin.x + 10 >= self.carImageView.frame.minX {
                    timer.invalidate()
                    self.isGameOver = true
                    self.navigationController?.popToRootViewController(animated: false)
                }
                
                self.carImageView.center.x -= 10
                
                if gestureReconizer.state != UIGestureRecognizer.State.began {
                    self.carImageView.transform = CGAffineTransform(rotationAngle: 0)
                    timer.invalidate()
                }
            })
    }
    
    private func setCar() {
        switch UserDefaults.standard.value(forKey: "carColor") as? String {
            case
                "yellow": createCar(name: "yellowCar.png")
            case
                "blue": createCar(name: "blueCar.png")
            default:
                createCar(name: "blueCar.png")
        }
    }
    
    private func setBarrier() {
        switch UserDefaults.standard.value(forKey: "barrier") as? String {
        case
            "bush": createBarrier(name: "item.png")
        case
            "conus": createBarrier(name: "item2.png")
        case
            "canistra": createBarrier(name: "item3.png")
        default:
            createBarrier(name: "item.png")
        }
    }
    
    private func buttonsDesign() {
        leftButton.layer.cornerRadius = leftButton.frame.height / 2
        rightButton.layer.cornerRadius = rightButton.frame.height / 2
    }
    
    private func createCar(name: String) {
        let image = UIImage(named: name)
        carImageView.image = image
        carImageView.contentMode = .scaleAspectFit
        carImageView.layer.shadowColor = UIColor.black.cgColor
        carImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        carImageView.layer.shadowOpacity = 0.3
        
        self.view.bringSubviewToFront(carImageView)
    }
    
    private func chooseSpeed() {
        if UserDefaults.standard.value(forKey: "speedCar") == nil {
            speedBarrier = 0.025
        } else {
            switch UserDefaults.standard.value(forKey: "speedCar") as! String {
            case "1":
                speedBarrier = 0.055
            case "2":
                speedBarrier = 0.045
            case "3":
                speedBarrier = 0.035
            case "4":
                speedBarrier = 0.025
            case "5":
                speedBarrier = 0.015
            default:
                break
            }
        }
    }
        
    private func createBarrier(name: String) {
        chooseSpeed()
        
        let image = UIImage(named: name)
        barrierImageView.image = image
        barrierImageView.contentMode = .scaleAspectFit
        barrierImageView.frame.origin.x = CGFloat(Int.random(in: 50 ..< Int(view.frame.width - 100)))
        barrierImageView.frame.origin.y = 0
        barrierImageView.bringSubviewToFront(barrierImageView)
        
        moveBarriersDown()
    }
    
    private func moveBarriersDown() {
        Timer.scheduledTimer(withTimeInterval: speedBarrier, repeats: true, block: { timer in
            self.barrierImageView.frame.origin.y += 5
            
            if self.carImageView.frame.intersects(self.barrierImageView.frame) {
                timer.invalidate()
                self.player?.stop()
                self.isGameOver = true
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let enterNameController = storyboard.instantiateViewController(identifier: "EnterNameViewController") as? EnterNameViewController {
                    enterNameController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(enterNameController, animated: false)
                }
            } else {
                if self.barrierImageView.frame.origin.y >= self.view.frame.height {
                    timer.invalidate()
                    
                    self.result += 1
                    self.resultLabel.text = "\(self.result)"
                    UserDefaults.standard.set(self.result, forKey: "points")
                    
                    switch UserDefaults.standard.value(forKey: "barrier") as? String {
                    case "bush":
                        self.createBarrier(name: "item.png")
                    case "conus":
                        self.createBarrier(name: "item2.png")
                    case "canistra":
                        self.createBarrier(name: "item3.png")
                    default:
                        self.createBarrier(name: "item.png")
                    }
                } else {
                    self.result += 0
                    self.resultLabel.text = "\(self.result)"
                    UserDefaults.standard.set(self.result, forKey: "points")
                }
            }
        })
    }
    
    private func createLines(pointX: Int) {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { _ in
            
            let line = UIView(frame: CGRect(x: pointX, y: -50, width: 10, height: 80))
            line.backgroundColor = UIColor.white
            line.layer.opacity = 0.5
           
            self.index += 1
            self.linesArray.append(line)
            self.view.addSubview(line)
            self.view.insertSubview(line, at: 1)
        
            UIView.animate(withDuration: 1.5, delay: 0, options: .curveLinear) {
            
            for index in 0 ... self.linesArray.count - 1 {
                self.linesArray[index].frame.origin.y = self.view.frame.height
            }
        }})
    }
}
