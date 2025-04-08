import SwiftUI

struct GameResultView: View {
    let result: GameResultType
    let stars: Int?
    let onRestart: (GameResultType) -> Void
    let onQuit: () -> Void
    
    var body: some View {
        ZStack {
            // Размытие заднего фона
            BlurView(style: .systemUltraThinMaterialDark)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                NavigationItem(title: "", type: .home) {
                    onQuit()
                }
                Spacer()
                StrokedText(
                    text: result == .win ? "YOU WIN!" : "YOU LOSE",
                    strokeColor: .white,
                    textColor: .blue,
                    size: 64
                )

                // Если победа, показываем звёзды
                if result == .win, let stars = stars {
                    HStack(spacing: 8) {
                        ForEach(0..<3) { index in
                            if index < stars {
                                Assets.Star.filled
                                    .resizable()
                                    .frame(width: 64, height: 64)
                            } else {
                                Assets.Star.empty
                                    .resizable()
                                    .frame(width: 64, height: 64)
                            }
                        }
                    }
                }
                
                Spacer()

                // Меняем кнопку в зависимости от результата
                MainButton(text: (result == .win) ? "NEXT" : "TRY AGAIN") {
                    onRestart(result)
                }
            }
            .padding()
        }
        .transition(.opacity)
    }
}

// Размытие через UIVisualEffectView
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
