class CardDetailVC: UIViewController {

    var cardNumber: String!
    var cardType: Bool!

    let visaColor = UIColor.init(r: 250, g: 170, b: 19, alpha: 0)
    let masterCardColor = UIColor.init(r: 34, g: 34, b: 34, alpha: 0)

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardViewBankNameLabel: UILabel!
    @IBOutlet weak var cardViewCardNumberLabel: UILabel!
    @IBOutlet weak var cardViewImage: UIImageView!

    func viewDidLoad {
        setupCardView()
    }

    func setupCardView() {

        self.cardView.layer.cornerRadius = 10

        setColorForCardView()

        self.cardViewBankNameLabel.text = "Bank"
        self.cardViewCardNumberLabel.text = "**** \(cardNumber.suffix(4))"

        setImageOfCard()
        
    }

    func setColorForCardView() {
        if (cardType == true) {
            self.cardView.backgroundColor = visaColor
        } else {
            self.cardView.backgroundColor = masterCardColor
        }
    }

    func setImageOfCard() {
        if (cardType == true) {
            self.cardViewImage.image = UIImage(named:"visa")
        } else {
            self.cardViewImage.image = UIImage(named:"master")
        }
    }

}