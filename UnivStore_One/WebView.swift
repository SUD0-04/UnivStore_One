//
//  WebView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var URLtoLoad: String

    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.URLtoLoad) else {
            return WKWebView()
        }

        let webview  = WKWebView()
        webview.navigationDelegate = context.coordinator // navigationDelegate 설정 추가
        webview.load(URLRequest(url: url))
        
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
    
    // Coordinator 추가
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

     class Coordinator: NSObject, WKNavigationDelegate {
         let parent: WebView

         init(_ parent: WebView) {
             self.parent = parent
         }

         // 스와이프 제스처에 응답하기 위한 메소드 추가
         func webView(_ webView: WKWebView, didFinish navigation:
          WKNavigation!) { webView.allowsBackForwardNavigationGestures = true }
     }
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(URLtoLoad: "https://www.myunidays.com/KR")
    }
}
