// * Flutter Module implementation on iOS Project with (StoryBoard implementation() 
import UIKit
import Flutter
import FlutterPluginRegistrant

class ViewController: UIViewController {
    let laraigoChatSocket = LaraigoChatSocket()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the button
        let launchButton = UIButton(type: .system)
        launchButton.setTitle("Launch Chat", for: .normal)
        launchButton.addTarget(self, action: #selector(launchChat), for: .touchUpInside)

        // Set up button constraints (adjust as needed)
        launchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(launchButton)
        NSLayoutConstraint.activate([
            launchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            launchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc func launchChat() {
        // Call the method to initialize the chat socket
        laraigoChatSocket.initChatSocket(integrationId: "63fe5143762b546856d9deb0", viewController: self)
    }
}

class LaraigoChatSocket {

    private var flutterEngine: FlutterEngine = FlutterEngine(name: "flutter_engine")
    private let channelName = "laraigo_chat_communication_channel"

    func initChatSocket(integrationId: String, viewController: UIViewController) {
        setupFlutterEngine()
        setupMethodChannel(integrationId)
        launchFlutterModule(viewController: viewController)
    }

    private func setupFlutterEngine() {
        flutterEngine.run()
    }

    private func setupMethodChannel(_ integrationId: String) {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let mapWithValues: [String: Any] = ["integrationId": integrationId]

        let channel = FlutterMethodChannel(
            name: channelName,
            binaryMessenger: flutterViewController.binaryMessenger
        )
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "testingSendData" {
                print("Sending map data to Flutter")
                result.self(mapWithValues)
            }
        }
        
    }

    private func launchFlutterModule(viewController: UIViewController) {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
}


// * Flutter Module implementation on iOS Project with (SwiftUI implementation() 
