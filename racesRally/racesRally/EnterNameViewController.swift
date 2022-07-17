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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        if let data = UserDefaults.standard.value(forKey: "gamerInfo") as? Data {
            do {
                gamersResult = try decoder.decode([Gamer].self, from: data)
            } catch {
                print(error.localizedDescription)
            } 
        }
        
        if let seconds = UserDefaults.standard.value(forKey: "result") as? Int {
            let gamer = Gamer(name: nameTextField.text!, seconds: seconds, time: dateFormatter.string(from: Date()))
            
            gamersResult.append(gamer)
            gamersResult.sort(by: { $0.seconds > $1.seconds })

            if gamersResult.count == 6 {
                gamersResult.removeLast()
            }
        }
        
        do {
            let data = try encoder.encode(gamersResult)
            UserDefaults.standard.set(data, forKey: "gamerInfo")
        } catch {
            print(error.localizedDescription)
        }
        
        nameTextField.text = nil
        self.navigationController?.popToRootViewController(animated: false)
    }
}
