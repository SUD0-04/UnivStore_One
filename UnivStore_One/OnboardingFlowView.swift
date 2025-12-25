import SwiftUI

struct OnboardingFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var step: Int = 1

    // Called when the user finishes step 2, passes Bool indicating Apple product usage
    var onFinish: (Bool) -> Void

    var body: some View {
        content
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

            if step == 1 {
                Image("onb_1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 600)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
            }
            if step == 2 {
                Image("onb_2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 600)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
            }

            Spacer()

            // YES / NO buttons centered at bottom
            Group {
                if step == 1 {
                    Button(action: { step = 2 }) {
                        Text("알겠습니다!")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(red: 0.478, green: 0.776, blue: 0.564))
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                    .padding(.horizontal, 24)
                } else {
                    HStack(spacing: 16) {
                        Button(action: { onFinish(true) }) {
                            Text("맞아요!")
                                .font(.system(size: 18, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color(red: 0.478, green: 0.776, blue: 0.564))
                                .foregroundStyle(.white)
                                .cornerRadius(14)
                        }
                        Button(action: { onFinish(false) }) {
                            Text("아니요")
                                .font(.system(size: 18, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color(red: 0.90, green: 0.93, blue: 0.90))
                                .foregroundStyle(.primary)
                                .cornerRadius(14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 24)
                }
            }

            Spacer().frame(height: 24)
        }
        .background(
            LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }

    private var titleForStep: String {
        switch step {
        case 1: return "꼭 확인해 주세요!"
        case 2: return "마지막입니다."
        default: return ""
        }
    }

    private var subtitleForStep: String {
        switch step {
        case 1: return "이 앱은 대학생, 교수 등 교육자에 한하여 사용이 가능합니다."
        case 2: return "iPhone,iPad,mac과 같은 Apple 제품을 사용하십니까?"
        default: return ""
        }
    }
}

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView(onFinish: { _ in })
    }
}
