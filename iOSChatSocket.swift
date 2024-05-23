
import SwiftUI
import Flutter

struct HomeView: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    @State var flutterBasicChannel : FlutterBasicMessageChannel?
    
    var body: some View {
        
        VStack {
            Button(action: {showFlutter()}) {
                            Text("Open Flutter View")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }.padding(.vertical, 10)
            }
        }
    func showFlutter(){
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
            let window = windowScene.windows.first(where: \.isKeyWindow),
            let rootViewController = window.rootViewController
        else { return }
        
        flutterBasicChannel = FlutterBasicMessageChannel(name: "laraigo_chat_communication_channel", binaryMessenger: flutterDependencies.flutterEngine.binaryMessenger, codec: FlutterStandardMessageCodec.sharedInstance())
        
        flutterBasicChannel?.sendMessage(["integrationId": "integrationId", "customMessage":"Hola"])
             
        // Create a FlutterViewController from pre-warm FlutterEngine
        let flutterViewController = FlutterViewController(
                 engine: flutterDependencies.flutterEngine,
                 nibName: nil,
                 bundle: nil)
        flutterViewController.modalPresentationStyle = .overCurrentContext
        flutterViewController.isViewOpaque = false
        rootViewController.present(flutterViewController, animated: true)
    }
}

#Preview {
    HomeView()
}
