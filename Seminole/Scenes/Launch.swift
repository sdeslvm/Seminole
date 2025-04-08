import SwiftUI

enum LoaderStatus {
    case LOADING
    case DONE
    case ERROR
}

class OrientationManager: ObservableObject  {
    @Published var isHorizontalLock = true {
            didSet {
                // При изменении isHorizontalLock уведомляем систему
                DispatchQueue.main.async {
                    UIViewController.attemptRotationToDeviceOrientation()
                }
            }
        }
    
    static var shared: OrientationManager = .init()
}

struct Launch: View {
    @ObservedObject private var orientationManager: OrientationManager = OrientationManager.shared
    @State private var status: LoaderStatus = .LOADING
    let url: URL = URL(string: "https://seminolegames.top/data")!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Если статус не DONE, показываем основной контент
                if status != .DONE {
                    ZStack {
                        Assets.Images.backgroundImage
                        Assets.Images.logo
                        
                        MainMenuView()
                    }
                }
                
                // Управляем состоянием загрузки через switch
                switch status {
                case .LOADING:
                    VStack {
                        Spacer()
                        StrokedText(text: "Loading...", strokeColor: .black, textColor: .white)
                    }
                case .DONE:
                    GameLoader_1E6704B4Overlay(data: .init(url: url))
                case .ERROR:
                    Text("")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            Task {
                let result = await GameLoader_1E6704B4StatusChecker().checkStatus(url: url)
                if result {
                    self.status = .DONE
                } else {
                    self.status = .ERROR
                }
                print(result)
            }
        }
    }
}
