//
//  TrackView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/04.
//

import SwiftUI

struct TrackView: View {
    @State private var trackingNumber = ""
    @State private var trackingInfo: String?
    
    func fetchTrackingInfo() {
        // 운송장 API 호출 및 데이터 가져오기 로직 구현
        // 예시로는 URLSession을 사용하여 GET 요청을 보내고 응답 데이터를 처리합니다.
        
        guard let url = URL(string: "https://apis.tracker.delivery/carriers/kr.cjlogistics/tracks/\(trackingNumber)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }
            
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(TrackingResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.trackingInfo = decodedResponse.info
                    }
                    return
                }
            }
            
            // API 호출이 실패하거나 데이터 처리에 실패한 경우에 대한 처리
            DispatchQueue.main.async {
                self.trackingInfo = "운송장 정보를 가져오지 못했습니다."
            }
        }.resume()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("배송 조회")
                .fontWeight(.bold)
                .font(.system(size: 40))
            
// 디자인 상의 이유로 제거
//            Image(systemName:"cart.fill")
//                .resizable()
//                .frame(width: 100, height: 80)
            
            TextField("운송장 번호 입력", text: $trackingNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 80)
            
            Button(action: fetchTrackingInfo) {
                Text("조회")
                    .padding(5)
                    .padding(.horizontal, 73)
                    .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .fontWeight(.bold)
            }
            
            Text(trackingInfo ?? "")
                .multilineTextAlignment(.center)
            
            Text(" 현재 운송장 조회는 CJ 대한통운만 지원됩니다.")
                .padding(.top, 270)
        }.padding()
    }
}

struct TrackingResponse: Codable { // 운송장 API 응답 데이터 모델 구조체
    let info: String
}


struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
