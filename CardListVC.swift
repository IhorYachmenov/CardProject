
class CardListVC: UIViewController {

    var cardNumber: String!
    var cardType: Bool!

    let cellIdentifier: String = "cell"

    @IBOutlet weak var addCard: UIButton!
    @IBOutlet weak var tableView: UITableView!

    func viewDidLoad {
        
    }

    @IBAction func addCard(sender: UIButton) {
        let randomInt = Int.random(in: 0000000000000000..<9999999999999999)
        let randomBool = Bool.random()

        guard let storage = UserDefaultsSettings.shared.getCardNumber != nil else {
            UserDefaultsSettings.shared.saveCardNumber(CreditCard(number: String(randomInt), isVisa: randomBool))
        } 
        storage.append(CreditCard(number: String(randomInt), isVisa: randomBool))

        DispatchQueue.main.async {
            UserDefaultsSettings.shared.removeAll()
            UserDefaultsSettings.shared.saveCardNumber(storage)
            self.tableView.reloadView()
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "cardDetail") {
            let vc = segue.destination as? CardDetailVC
            vc?.cardNumber = self.cardNumber
            vc?.cardType = self.cardType
        }
    }


}

extension CardListVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = UserDefaultsSettings.shared.getCardNumber != nil else { return 0 }

        return number.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as CustomCell!
        let storage = UserDefaultsSettings.shared.getCardNumber
        guard storage != nil else { return cell }

        if (storage.reversed()[indexPath].isVisa == true) {
            cell.image = UIImage(named: "visa")
        } else {
            cell.image = UIImage(named: "master")
        }

        cell.cardNumber = "**** **** **** \(storage.reversed()[indexPath].cardNumber.suffix(4))"

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        let storage = UserDefaultsSettings.shared.getCardNumber

        self.cardNumber = storage.reversed()[indexPath.row].cardNumber
        self.cardType = storage.reversed()[indexPath.row].isVisa
        self.performSegue(withIdentifier: "cardDetail", sender: self)
            
    }
}

