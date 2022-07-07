import UIKit

extension UIButton {
    func setRadiusWithShadow(_ radius: CGFloat? = nil) {
        self.layer.cornerRadius = 28
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
    }
}
