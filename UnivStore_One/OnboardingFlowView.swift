import SwiftUI

struct OnboardingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var step: Int = 1

    // Called when the user finishes step 2
    var onFinish: () -> Void

    var body: some View {
        content
            .fullScreenCover(isPresented: .constant(true), content: {
                content
            })
    }

    @ViewBuilder
    private var content: some View {
        VStack {
            // Top bar with back button (hidden on first step)
            HStack {
                if step > 1 {
                    Button(action: { withAnimation { step -= 1 } }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .padding(.leading)
                } else {
                    // keep layout space consistent
                    Color.clear.frame(width: 44, height: 44)
                        .padding(.leading)
                }
                Spacer()
            }
            .frame(height: 44)
            .padding(.top, 8)

            Spacer()

            // Centered container; content is left-aligned inside
            VStack(alignment: .leading, spacing: 12) {
                Text(titleForStep)
                    .font(.system(size: 40, weight: .bold))
                Text(subtitleForStep)
                    .font(.system(size: 25))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 600) // constrain for nice layout on wide screens
            .padding(.horizontal, 24)
            .multilineTextAlignment(.leading)

            Spacer()

            // YES / NO buttons centered at bottom
            HStack(spacing: 16) {
                Button(action: { handleAnswer(true) }) {
                    Text("YES")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                        .foregroundStyle(.white)
                        .cornerRadius(14)
                }
                Button(action: { handleAnswer(false) }) {
                    Text("NO")
                        .font(.system(size: 18, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.tertiarySystemBackground))
                        .foregroundStyle(.primary)
                        .cornerRadius(14)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 24)

            Spacer().frame(height: 24)
        }
        .background(
            LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .animation(.easeInOut(duration: 0.25), value: step)
    }

    private var titleForStep: String {
        switch step {
        case 1: return "초기 설정 1"
        case 2: return "초기 설정 2"
        default: return ""
        }
    }

    private var subtitleForStep: String {
        switch step {
        case 1: return "앱 사용을 위한 기본 설정을 확인합니다."
        case 2: return "마지막으로 선호도를 선택해 주세요."
        default: return ""
        }
    }

    private func handleAnswer(_ yes: Bool) {
        if step == 1 {
            withAnimation { step = 2 }
        } else {
            // Finish onboarding
            onFinish()
        }
    }
}

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView(onFinish: {})
    }
}
