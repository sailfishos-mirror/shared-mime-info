// A greeting, in Swift.
struct Greeter {
    let name: String

    func greet() -> String {
        return "Hello, \(name)!"
    }
}

print(Greeter(name: "world").greet())
