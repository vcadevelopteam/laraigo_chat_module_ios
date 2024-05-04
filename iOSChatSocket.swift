
import SwiftUI
import Flutter

struct HomeView: View {
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    @State var flutterMethodChannel : FlutterMethodChannel?
    
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
        
        flutterMethodChannel = FlutterMethodChannel(name: "laraigo_chat_communication_channel", binaryMessenger: flutterDependencies.flutterEngine.binaryMessenger)
    
        flutterMethodChannel?.invokeMethod("testingSendData", arguments: ["integrationId":"6567ade24933f425469910e1"])
             
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
