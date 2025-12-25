import SwiftUI

struct StartView: View {
    @AppStorage("hasSeenStart") private var hasSeenStart: Bool = false
    @State private var animate = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                VStack(spacing: 8) {
                    Text("학생통합스토어")
                        .font(.system(size: 40, weight: .bold))
                        .scaleEffect(animate ? 1.05 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)

                    Text("새 학기처럼 설레는 학생 할인")
                        .font(.system(size: 17))
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

                Image("Intro_image")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 280)
                    .padding(.vertical, 8)
                    .opacity(0.95)
                    .scaleEffect(animate ? 1.03 : 1.0)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)

                Spacer()

                Button(action: { hasSeenStart = true }) {
                    Text("시작하기")
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                        .foregroundStyle(.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 24)
                }
                .accessibilityIdentifier("startButton")

                Text("언제든 설정에서 다시 볼 수 있어요")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Spacer().frame(height: 24)
            }
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    StartView()
}
