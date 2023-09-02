//
//  ContentView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: About_me().edgesIgnoringSafeArea(.all)) {
                    Text("About")
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                        .font(.system(size: 12))
                }.padding(.leading, 240).padding(.bottom, 50)
                
                Text("새로운 Mac과 iPad를 할인가로 만나보세요")
                Text("학생통합스토어")
                    .fontWeight(.bold)
                    .font(.system(size: 55))
                Image("Intro_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit) // 원본 비율 유지
                    .frame(width: 350) // 너비만 지정. 높이는 자동으로 계산됩니다.
                    .padding(.bottom,250)
                HStack {
                    NavigationLink(destination: WebView(URLtoLoad: "https://www.myunidays.com/KR/ko-KR/account/log-in").edgesIgnoringSafeArea(.all)){
                        Text("유니데이즈")
                            .fontWeight(.bold)
                            .padding(15)
                            .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .font(.system(size: 20))
                    }
                    
                    NavigationLink(destination: WebView(URLtoLoad: "https://www.univstore.com")
                        .edgesIgnoringSafeArea(.bottom)) {
                        Text("학생복지스토어")
                                .fontWeight(.bold)
                                .padding(15)
                                .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                                .foregroundColor(Color.white)
                                .cornerRadius(20)
                                .font(.system(size: 20))
                    }
                    
                    
                    
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
