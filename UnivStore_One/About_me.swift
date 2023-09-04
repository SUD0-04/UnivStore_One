//
//  About_me.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI

struct About_me: View {

    var body: some View {
        VStack {
            Text("About")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.top,5)
            
            Text("1.1 Beta") // 소프트웨어 버전
                .font(.body)
            
            NavigationLink(destination: Check_about()) {
                Text("구매 관련 문의")
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .font(.system(size: 20))
            }.padding(30)
            
            NavigationLink(destination: TrackView()) {
                Text("실시간 배송 조회")
                    .fontWeight(.bold)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .font(.system(size: 20))
            }.padding(-20)
            
            Text("본 앱은 스토어 편의 사용을 위해 개발되었습니다. \n 구매 관련 문제 해결은 각 스토어에 문의하시기 바랍니다.") // 주의사항 안내
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 350)
        }
    }
}


struct About_me_Previews: PreviewProvider {
    static var previews: some View {
        About_me()
    }
}
