//
//  ContentView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var webViewNavigation1 = WebViewNavigation()
    @ObservedObject var webViewNavigation2 = WebViewNavigation()

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 8) {
                    HStack {
                        Spacer()
                        NavigationLink(destination: About_me().edgesIgnoringSafeArea(.all)) {
                            Text("About")
                                .fontWeight(.bold)
                                .padding(10)
                                .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                                .foregroundColor(Color.white)
                                .cornerRadius(20)
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.bottom, 12)
                    
                    Text("새 학기처럼 설레는 학생 할인")
                        .font(.system(size: 17))
                        .foregroundStyle(.secondary)
                        .padding(.bottom, -5)
                    Text("학생통합스토어")
                        .fontWeight(.bold)
                        .font(.system(size: 55))
                    Image("Intro_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit) // 원본 비율 유지
                        .frame(width: 350) // 너비만 지정. 높이는 자동으로 계산됩니다.
                        .padding(.bottom, 4)
                }
                
                Spacer().frame(height: 300)
                
                HStack {
                    NavigationLink(destination:
                        ZStack{
                            WebView(navigationState: webViewNavigation1, urlToLoad:"https://www.myunidays.com/KR/ko-KR/account/log-in").edgesIgnoringSafeArea(.all)
                            
                            VStack{
                                Spacer()

                                HStack{
                                    Button(action:{
                                        self.webViewNavigation1.webView?.goBack()
                                    }){
                                        Image(systemName:"chevron.backward.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                     }
                                     .disabled(!webViewNavigation1.canGoBack)

                                    Spacer()

                                    Button(action:{
                                        self.webViewNavigation1.webView?.goForward()
                                    }){
                                        Image(systemName:"chevron.forward.circle.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                     }
                                     .disabled(!webViewNavigation1.canGoForward)
                                }.padding()
                            }
                        }
                    )
                    {
                        Text("UNIDAYS")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .padding(.bottom, 20)

                    NavigationLink(destination:
                        ZStack{
                        WebView(navigationState:self.webViewNavigation2,urlToLoad:"https://www.univstore.com").edgesIgnoringSafeArea(.bottom)

                           VStack{
                               Spacer()

                               HStack{
                                   Button(action:{
                                       self.webViewNavigation2.webView?.goBack()
                                   }){
                                       Image(systemName:"chevron.backward.circle.fill")
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                   }
                                   .disabled(!webViewNavigation2.canGoBack)

                                   Spacer()

                                   Button(action:{
                                       self.webViewNavigation2.webView?.goForward()
                                   }){
                                       Image(systemName:"chevron.forward.circle.fill")
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                   }
                                  .disabled(!webViewNavigation2.canGoForward)
                               }.padding()
                           }

                       })
                       {
                          Text("학생복지스토어")
                              .fontWeight(.bold)
                              .font(.system(size: 20))
                              .frame(maxWidth: .infinity)
                              .padding(.vertical, 12)
                       }
                       .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                       .foregroundColor(Color.white)
                       .cornerRadius(20)
                       .padding(.bottom, 20)

                  }
                .padding(.horizontal, 24)

              }

          }

      }

    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

#if DEBUG
// Lightweight preview wrapper to avoid WebView/network dependencies in Canvas
struct ContentView_PreviewWrapper: View {
    var body: some View {
        NavigationView {
            VStack {
                // About Button (static for preview)
                Text("About")
                    .fontWeight(.bold)
                    .padding(10)
                    .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 12))
                    .padding(.bottom, 50)

                Text("새로운 Mac과 iPad를 할인가로 만나보세요")
                Text("학생통합스토어")
                    .fontWeight(.bold)
                    .font(.system(size: 55))
                Image("Intro_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                    .padding(.bottom, 80)

                HStack {
                    Text("UNIDAYS")
                        .fontWeight(.bold)
                        .padding(15)
                        .padding(.horizontal)
                        .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .font(.system(size: 20))

                    Text("학생복지스토어")
                        .fontWeight(.bold)
                        .padding(15)
                        .background(Color(red: 0.066, green: 0.251, blue: 0.828))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .font(.system(size: 20))
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView_PreviewWrapper()
}
#endif

