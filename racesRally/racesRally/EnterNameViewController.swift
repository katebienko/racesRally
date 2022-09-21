import UIKit

class EnterNameViewController: UIViewController {
   
    var gamersResult: [Gamer] = []
    
    let decoder = JSONDecoder() // превращает данные в объект
    let encoder = JSONEncoder() // превращает объект в данные
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var saveResultButton: UIButton!
    @IBOutlet private weak var imageBG: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage()
        saveResultButton.setRadiusWithShadow()
    }
    
    private func backgroundImage() {
        let roadBg = UIImage(named: "roadBG.jpg")
        imageBG.image = roadBg
        
        self.view.insertSubview(imageBG, at: 0)
    }
    
    @IBAction func saveResult(_ sender: Any) {
            if let data = UserDefaults.standard.value(forKey: "gamerInfo") as? Data {
                do {
                    gamersResult = try decoder.decode([Gamer].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            if let points = UserDefaults.standard.value(forKey: "myPoints") as? Int {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                
                let gamer = Gamer(name: nameTextField.text!, seconds: points, time: dateFormatter.string(from: Date()))

                gamersResult.append(gamer)
                gamersResult.sort(by: { $0.seconds > $1.seconds })

                if gamersResult.count > 10 {
                    gamersResult.removeLast()
                }
                
                if points == 0 {
                    navigationController?.popToRootViewController(animated: true)
                } else {
                    showShareAlert()
                }
            }
            
            do {
                let data = try encoder.encode(gamersResult)
                UserDefaults.standard.set(data, forKey: "gamerInfo")
            } catch {
                print(error.localizedDescription)
            }
        }
    
    private func showShareAlert() {
        navigationController?.popToRootViewController(animated: false)
        
        let alert = UIAlertController(title: "Share a result on Twitter", message: "Do you want to share your result?", preferredStyle: .alert)
        
        if let points = UserDefaults.standard.value(forKey: "myPoints") as? Int {
            alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (action) in
                let shareText = "My result at RacesRally - \(points) points!"
                
                //convert to a string that can be used in URL queries
                guard let encodedText = shareText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
    
                guard let tweetURL = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") else {
                return }
                
                UIApplication.shared.open(tweetURL)
            }))
            
            alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action) in
                self.navigationController?.popToRootViewController(animated: false)
            }))
            
            self.present(alert, animated: false, completion: nil)
        }
    }
}
