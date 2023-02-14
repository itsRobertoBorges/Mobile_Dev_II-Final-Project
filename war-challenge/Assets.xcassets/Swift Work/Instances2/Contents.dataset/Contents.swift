struct DatabaseManager {
    func saveData(data:String) -> Bool {
        // This code saces the data and returns a boolean result
        return true
    }
}

struct ChatView {
    var message = "Hello"
    
    func sendChat() {
        // Save chat message
        var db = DatabaseManager()
        let success = db.saveData(data: message)
        
        // check successful boolean value, if false show alert to user
    }
}
