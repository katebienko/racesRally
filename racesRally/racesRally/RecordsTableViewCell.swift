import UIKit

class RecordsTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pointsLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = "Unknown_name"
        pointsLabel.text = "Unknown_points"
        dateLabel.text = "Unknown_dates"
    }
    
    func setup(with info: Gamer) {    
        nameLabel.text = info.name
        pointsLabel.text = String(info.seconds)
        dateLabel.text = info.time
    }
}
