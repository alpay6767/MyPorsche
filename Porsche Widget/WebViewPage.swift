//
//  WebViewPage.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 03.11.22.
//

import Foundation
import WebKit

class WebViewPage: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webview: WKWebView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()

        webView.navigationDelegate = self

        view = webView
        
        let url = URL(string: "https://www.google.com")!

        webView.load(URLRequest(url: url))

        webView.allowsBackForwardNavigationGestures = true
    }
    
}
