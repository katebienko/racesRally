import UIKit

class RecordsViewController: UIViewController {
    
    private var labelsNames = [UILabel]()
    private var labelSeconds = [UILabel]()
    private var labelsTime = [UILabel]()
    
    let decoder = JSONDecoder() // превращает данные в объект
    let encoder = JSONEncoder() // превращает объект в данные
    
    @IBOutlet private weak var resultTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var roadBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        createRoad()
        backButton.setRadiusWithShadow()
        
        resultTableView.dataSource = self
        resultTableView.reloadData()
    }
    
    private func createRoad() {
        let roadBg = UIImage(named: "roadBG.jpg")
        roadBackground.image = roadBg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    @IBAction func backToMainPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
    }
}

extension RecordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsTableViewCell") as? RecordsTableViewCell
        else {
            fatalError()
        }
        
        if let data = UserDefaults.standard.value(forKey: "gamerInfo") as? Data {
            do {
                let gamersResult = try decoder.decode([Gamer].self, from: data)
                cell.setup(with: gamersResult[indexPath.row])
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = UserDefaults.standard.value(forKey: "gamerInfo") as? Data else { return 0 }
        let gamersResult = try? decoder.decode([Gamer].self, from: data)
        
        return gamersResult!.count
    }
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
