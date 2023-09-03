//
//  Check_about.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/03.
//

import SwiftUI

struct Check_about: View {
    
    let phoneNumber = "010-1234-5678" // 유니데이즈 전화번호
    let phoneNumber2 = "02-6352-9331" // 학생복지스토어 전화번호
    
    @State private var isShowingPhoneAlert = false
    @State private var isShowingPhoneAlert2 = false
    
    var body: some View {
        VStack {
            Text("온라인 해결이 어려우신가요?")
                .fontWeight(.bold)
                .font(.system(size: 25))
                .padding(4)
            
            Text("전화를 통해 해결해보세요.")
                .padding(.bottom, 100)
            
            Button(action: {
                            isShowingPhoneAlert2 = true
                        }) {
                            Text("학생복지스토어 고객센터")
                                .fontWeight(.bold)
                                .padding(.horizontal, 50)
                                .padding(.vertical, 10)
                                .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                                .foregroundColor(Color.white)
                                .cornerRadius(20)
                                .font(.system(size: 20))
                        }
                    }
                    .alert(isPresented: $isShowingPhoneAlert2) {
                        Alert(title: Text("전화 걸기"), message: Text("전화를 거시겠습니까?"), primaryButton:
                            Alert.Button.default(Text("전화 걸기"), action: {
                                guard let url = URL(string: "tel://\(phoneNumber2)") else { return }
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }), secondaryButton:
                            Alert.Button.cancel(Text("취소"), action:nil))
        }
        
    }
}

struct Check_about_Previews: PreviewProvider {
    static var previews: some View {
        Check_about()
    }
}

