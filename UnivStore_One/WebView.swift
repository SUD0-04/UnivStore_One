//
//  WebView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/01.
//

import SwiftUI
import WebKit

class WebViewNavigation: NSObject, ObservableObject, WKNavigationDelegate {
    @Published var canGoBack = false
    @Published var canGoForward = false
    
    var webView: WKWebView? {
        didSet {
            self.webView?.navigationDelegate = self
        }
    }

   func webView(_ webView: WKWebView, didFinish navigation:
     WKNavigation!) {
       canGoBack = webView.canGoBack
       canGoForward = webView.canGoForward
   }
}

struct WebView : UIViewRepresentable {

   @ObservedObject var navigationState = WebViewNavigation()

   let urlToLoad : String

   func makeUIView(context : Context) -> WKWebView{
       guard let url = URL(string:self.urlToLoad) else{
           return WKWebView()
       }

       let webview  = WKWebView()
       
       webview.navigationDelegate=self.navigationState // navigationDelegate 설정 추가
       
       webview.load(URLRequest(url:url))

       self.navigationState.webView=webview

      return webview
      
  }

  func updateUIView(_ uiView : WKWebView, context : Context){
     // Nothing to do here
  }
  
}



struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlToLoad: "https://www.myunidays.com/KR")
    }
}
