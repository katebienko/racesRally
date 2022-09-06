import UIKit

class OnBoardingViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let titles = ["Drive around barriers and get points!", "Control the car with buttons or using the accelerometer!", "Share your results on social media!"]
    
    @IBOutlet var holderView: UIView!
    @IBOutlet weak var roadBackground: UIImageView!

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        createRoad()
        configure()
    }
    
    private func createRoad() {
        let roadBg = UIImage(named: "roadBG.jpg")
        roadBackground.image = roadBg
        
        self.view.insertSubview(roadBackground, at: 0)
    }
    
    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        for x in 0 ..< 3 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            
            scrollView.addSubview(pageView)
            
            let label = UILabel(frame: CGRect(x: 10, y: pageView.frame.height - 200, width: pageView.frame.size.width - 20, height: 120))
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 22)
            label.numberOfLines = 4
            label.textColor = .white
            pageView.addSubview(label)
            label.text = titles[x]
                        
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 420, height: 420))
            imageView.center.y = view.center.y - 100
            
            imageView.center.x = view.center.x
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x + 1)")
            pageView.addSubview(imageView)
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 335, height: 60))
            button.center.y = holderView.frame.size.height - button.frame.height
            button.center.x = view.center.x
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.setTitle("NEXT", for: .normal)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.setRadiusWithShadow()
            
            if x == 2 {
                button.setTitle("GET STARTED", for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x + 1
            pageView.addSubview(button)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 3 else {
            Core.shared.setIsNotNewUser()
            dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: false)
            
            return
        }
        
        // Scroll to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}
