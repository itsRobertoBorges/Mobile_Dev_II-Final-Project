
class MyStructure {
    var message = "hello"
    
    func function(){
        print(message)
    }
}

var a: MyStructure = MyStructure()

a.message = "Hello sir."
a.function()

var b = MyStructure()
b.message = "World"
print(b.message)
