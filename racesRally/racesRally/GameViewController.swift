import UIKit
import AVKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var isGameOver: Bool = false
    var index = 0
    var linesArray: [UIView] = [UIView()]
    var speedBarrier: Double = 0.00
    var result: Int = 0
    var player: AVAudioPlayer?
    
    @IBOutlet private weak var carImageView: UIImageView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var bushImageView: UIImageView!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var roadBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let audioURL = Bundle.main.url(forResource: "car", withExtension: "mp3") {
            self.player = try? AVAudioPlayer(contentsOf: audioURL)
            player?.play()
        }
        
        createRoad()
        buttonsDesign()
        createLinesLeft()
        createLinesRight()
        chooseCar()
        chooseBarrier()
        longPressGestiresRecognizersButtons()
    }
    
    private func createRoad() {
        let bg = UIImage(named: "roadBG.jpg")
        roadBackground.image = bg
        
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
    
    private func chooseCar() {
        if UserDefaults.standard.value(forKey: "carColor") == nil {
            createBlueCar()
        }
        else {
            if UserDefaults.standard.value(forKey: "carColor") as! String == "yellow" {
                createYellowCar()
            } else if UserDefaults.standard.value(forKey: "carColor") as! String == "blue" {
                createBlueCar()
            }
        }
    }
    
    private func chooseBarrier() {
        if UserDefaults.standard.value(forKey: "barrier") == nil {
            createBush()
        }
        else {
            if UserDefaults.standard.value(forKey: "barrier") as! String == "bush" {
                createBush()
            } else if UserDefaults.standard.value(forKey: "barrier") as! String == "conus" {
                createConus()
            } else if UserDefaults.standard.value(forKey: "barrier") as! String == "canistra" {
                createCanistra()
            }
        }
    }
    
    private func buttonsDesign() {
        leftButton.layer.cornerRadius = leftButton.frame.height / 2
        rightButton.layer.cornerRadius = rightButton.frame.height / 2
    }

    private func createBlueCar() {
        let image = UIImage(named: "myCar.png")
        carImageView.image = image
        carImageView.contentMode = .scaleAspectFit
        carImageView.layer.shadowColor = UIColor.black.cgColor
        carImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        carImageView.layer.shadowOpacity = 0.3
        
        self.view.bringSubviewToFront(carImageView)
    }
    
    private func createYellowCar() {
        let image = UIImage(named: "yellowCar.png")
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
        }
        
        else {
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
    
    private func createBush() {
        chooseSpeed()
        
        let image = UIImage(named: "item.png")
        bushImageView.image = image
        bushImageView.contentMode = .scaleAspectFit
        bushImageView.frame.origin.x = CGFloat(Int.random(in: 50 ..< Int(view.frame.width - 100)))
        bushImageView.frame.origin.y = 0
        bushImageView.bringSubviewToFront(bushImageView)
        
        moveBarriersDown()
    }
    
    private func createConus() {
        chooseSpeed()
        
        let image = UIImage(named: "item2.png")
        bushImageView.image = image
        bushImageView.contentMode = .scaleAspectFit
        bushImageView.frame.origin.x = CGFloat(Int.random(in: 50 ..< Int(view.frame.width - 100)))
        bushImageView.frame.origin.y = 0
        bushImageView.bringSubviewToFront(bushImageView)

        moveBarriersDown()
    }
    
    private func createCanistra() {
        chooseSpeed()
        
        let image = UIImage(named: "item3.png")
        bushImageView.image = image
        bushImageView.contentMode = .scaleAspectFit
        bushImageView.frame.origin.x = CGFloat(Int.random(in: 50 ..< Int(view.frame.width - 100)))
        bushImageView.frame.origin.y = 0
        bushImageView.bringSubviewToFront(bushImageView)

        moveBarriersDown()
    }
    
    private func moveBarriersDown() {
        Timer.scheduledTimer(withTimeInterval: speedBarrier, repeats: true, block: { timer in
            self.bushImageView.frame.origin.y += 5
            
            if self.carImageView.frame.intersects(self.bushImageView.frame) {
                timer.invalidate()
                self.isGameOver = true
                self.player?.stop()
               // self.navigationController?.popToRootViewController(animated: false)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let enterNameController = storyboard.instantiateViewController(identifier: "EnterNameViewController") as? EnterNameViewController {
                    enterNameController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(enterNameController, animated: false)
                }
            }
            else {
                if self.bushImageView.frame.origin.y >= self.view.frame.height {
                    timer.invalidate()
                    
                    self.result += 1
                    self.resultLabel.text = "\(self.result)"
                    UserDefaults.standard.set(self.result, forKey: "result")
                    
                    if UserDefaults.standard.value(forKey: "barrier") == nil {
                        self.createBush()
                    }
                    
                    else {
                        if UserDefaults.standard.value(forKey: "barrier") as! String == "bush" {
                            self.createBush()
                        } else if UserDefaults.standard.value(forKey: "barrier") as! String == "conus" {
                            self.createConus()
                        } else if UserDefaults.standard.value(forKey: "barrier") as! String == "canistra" {
                            self.createCanistra()
                        }
                    }
                }
                else {
                    self.result += 0
                    self.resultLabel.text = "\(self.result)"
                    UserDefaults.standard.set(self.result, forKey: "result")
                }
            }
        })
    }
    
    private func createLinesLeft() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { timer in
            
            let line = UIView(frame: CGRect(x: 125, y: -50, width: 10, height: 80))
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
    
    private func createLinesRight() {
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true, block: { timer in
            
            let line = UIView(frame: CGRect(x: self.view.frame.maxX - 125, y: -50, width: 10, height: 80))
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
