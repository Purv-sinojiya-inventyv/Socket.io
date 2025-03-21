import UIKit
import SocketIO

class ViewController: UIViewController {

    // 1. Create a SocketManager instance
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!, config: [.log(true), .compress])
    
    var socket: SocketIOClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSocket()
    }

    // 2. Initialize and connect the socket
    func setupSocket() {
        socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { data, ack in
            print(" Connected to Socket.IO Server!")
        }

        socket.on(clientEvent: .disconnect) { data, ack in
            print(" Disconnected from Server!")
        }

        socket.on("message") { (data, ack) in
            if let message = data.first as? String {
                print(" Received message: \(message)")
            }
        }

        socket.connect()
    }

    // 3. Function to send a message
    @IBAction func sendMessage(_ sender: UIButton) {
        let message = "Hello from iOS!"
        socket.emit("message", message)
        print(" Sent: \(message)")
    }
}
