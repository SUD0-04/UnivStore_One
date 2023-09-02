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
            Text("개발중인 버전입니다.") // 소프트웨어 버전
                .font(.body)
// 개발자 정보 표시 기능 비활성화
//            Image("Developer_icon") // 개발자 아이콘
//                .resizable()
//                .aspectRatio(contentMode: .fit) // 원본 비율 유지
//                .frame(width: 300) // 너비만 지정. 높이는 자동으로 계산됩니다.
            
            Text("본 앱은 스토어 편의 사용을 위해 개발되었습니다.\n구매 관련 문제 해결은 각 스토어에 문의하시기 바랍니다.") // 주의사항 안내
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top, 500)
        }
    }
}

struct About_me_Previews: PreviewProvider {
    static var previews: some View {
        About_me()
    }
}
