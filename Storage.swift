class UserDefaultsSettings: NSObject {

    static let shared = UserDefaultsSettings()
    private key = "cardNumber"
    
    func saveCardNumber(player: [CreditCard]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(player), forKey:key)
        UserDefaults.standard.synchronize()
    }

    func getCardNumber() -> [CreditCard]? {
        if let data = UserDefaults.standard.value(forKey:key) as? Data {
            let decodedSports = try? PropertyListDecoder().decode([CreditCard].self, from: data)
            return decodedSports
        }
        return nil
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(for:key)
        UserDefaults.standard.synchronize()
    }
    
}