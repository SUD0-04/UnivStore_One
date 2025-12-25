//
//  Check_about.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/03.
//

import SwiftUI

struct Check_about: View {
    
    let phoneNumber = "https://www.myunidays.com/KR/ko-KR/support/contact"
    // UNIDAYS 지원 문의; 전화번호가 없으므로 지원 문의로 대체
    let phoneNumber2 = "02-6352-9331" // 학생복지스토어 전화번호
    
    @State private var isShowingPhoneAlert = false 
    @State private var isShowingPhoneAlert2 = false
    @State private var isShowingUNIDAYSAlert = false
    
    var body: some View {
        VStack {
            Text("문제가 발생하였나요?")
                .fontWeight(.bold)
                .font(.system(size: 35))
                .padding(4)
            
            Text("전화 및 온라인 지원을 통해 해결해보세요.")
                .padding(.bottom, 12)

            Image("ca_img")
                .resizable()
                .scaledToFit()
                .frame(height: 400)
                .padding(.bottom, 24)
            
            // UNIDAYS 지원 문의;Safari에서 전개
            Button(action: {
                isShowingUNIDAYSAlert = true
            }) {
                Text("UNIDAYS 지원 문의")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .background(Color(red: 0.066, green: 0.251, blue: 0.828))
            .foregroundColor(Color.white)
            .cornerRadius(20)
            Spacer().frame(height: 16)
            
            // 학생복지스토어 고객센터 연결
            Button(action: {
                isShowingPhoneAlert2 = true
            }) {
                Text("학생복지스토어 고객센터")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .background(Color(red: 0.066, green: 0.251, blue: 0.828))
            .foregroundColor(Color.white)
            .cornerRadius(20)
        }
        .padding(.horizontal, 24)
        .alert(isPresented: $isShowingUNIDAYSAlert) {
            Alert(title: Text("Safari 열기"), message: Text("UNIDAYS 지원 페이지를 Safari에서 여시겠습니까?"), primaryButton:
                    Alert.Button.default(Text("열기"), action: {
                        guard let url = URL(string: phoneNumber) else { return }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }), secondaryButton:
                    Alert.Button.cancel(Text("취소"), action:nil))
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
