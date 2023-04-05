//
//  ViewController.swift
//  WebviewTest
//
//  Created by Ansh Singh on 05/04/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webview: WKWebView!
    
    lazy var normalWebview: UIButton = {
        let button = UIButton()
        button.setTitle("Normal Loading", for: .normal)
        button.backgroundColor = .blue
        button.isHidden = false
        button.addTarget(self, action: #selector(normalButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var preloadedWebview: UIButton = {
        let button = UIButton()
        button.setTitle("Faster Loading", for: .normal)
        button.backgroundColor = .blue
        button.isHidden = false
        button.addTarget(self, action: #selector(fasterWebviewTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(normalWebview)
        view.addSubview(preloadedWebview)
        normalWebview.frame = CGRect(x: 100, y: 400, width: 200, height: 100)
        preloadedWebview.frame = CGRect(x: 100, y: 600, width: 200, height: 100)
        initiateWebview()
    }
    
    func initiateWebview() {
        webview = WKWebView()
        let url = URL(string: "https://www.amazon.com/")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        webview.navigationDelegate = self
    }
    
    @objc func normalButtonTapped() {
        let vc = CustomWebViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func fasterWebviewTapped() {
        let vc = CustomWebViewController()
        vc.webview = webview
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewAlreadyLoaded = true
        print("did finish secret loading on \(printCurrentTime())")
    }
    
    func printCurrentTime() -> String {
        let currentDateTime = Date()

        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short

        return formatter.string(from: currentDateTime)
    }
    
    


}

