import UIKit
import RxSwift
import RxCocoa

class RecordsViewController: UIViewController {
    
    private var labelsNames = [UILabel]()
    private var labelSeconds = [UILabel]()
    private var labelsTime = [UILabel]()
    
    private let disposeBag = DisposeBag()
    var datasource = BehaviorSubject(value: [Gamer]())
    
    let decoder = JSONDecoder() // превращает данные в объект
    let encoder = JSONEncoder() // превращает объект в данные
    
    @IBOutlet private weak var resultTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var roadBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datasource.bind(to: resultTableView.rx.items(cellIdentifier: "RecordsTableViewCell", cellType: RecordsTableViewCell.self)) {
            index, model, cell in
            cell.setup(with: model)
        }
        .disposed(by: disposeBag)
        
        if let data = UserDefaults.standard.value(forKey: "gamerInfo") as? Data {
            do {
                let gamersResult = try decoder.decode([Gamer].self, from: data)
                       
                if var currentValues = try? self.datasource.value() {
                    currentValues.append(contentsOf: gamersResult)
                    self.datasource.onNext(currentValues)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
            
        setBackground()
        backButton.setRadiusWithShadow()
    }
    
    private func setBackground() {
        let roadBg = UIImage(named: "roadBG.jpg")
        roadBackground.image = roadBg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    @IBAction func backToMainPage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: false)
    }
}
