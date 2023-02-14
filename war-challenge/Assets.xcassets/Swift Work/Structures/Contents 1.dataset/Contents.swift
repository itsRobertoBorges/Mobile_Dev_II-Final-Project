


struct ChatView {
    // All the code in this structure belong to ChatView, variables, methods etc.
    
    // Properties
    var message:String = "Hello"
    var messageWithPrefix:String {
        let prefix = "Roberto Says: "
        return prefix + message
    }
    
    // View Code for this screen
    
    // Methods
    func sendChat(){
        
        // Code to send chat
        print(messageWithPrefix)
    }
    
    func deleteChat(){
        print(messageWithPrefix)
    }
    
}
