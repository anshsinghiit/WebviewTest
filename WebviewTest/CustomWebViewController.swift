//
//  CustomWebViewController.swift
//  WebviewTest
//
//  Created by Ansh Singh on 05/04/23.
//

import Foundation
import UIKit
import WebKit

var webViewAlreadyLoaded = false

class CustomWebViewController: UIViewController, WKNavigationDelegate {
    
    var webview: WKWebView!
    
    var navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("← Back", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var timeTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewDidLoadAt: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewDidLoadAt = Date()
        if webview == nil {
            loadWebView()
        } else if webViewAlreadyLoaded {
            timeTitle.text = "Webview already loaded"
        }
        
        view.addSubview(navigationBar)
        view.addSubview(leftButton)
        view.addSubview(timeTitle)
        view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.heightAnchor.constraint(equalToConstant: 32),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            leftButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 12),
            
            timeTitle.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            timeTitle.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            
            webview.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func loadWebView() {
        webview = WKWebView()
        let url = URL(string: "https://www.amazon.com/")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        webview.navigationDelegate = self
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        print("Did appear on \(printCurrentTime())")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("did finish loading on \(printCurrentTime())")
        if let date = viewDidLoadAt {
            timeTitle.text = "TimeTaken:\(Date().timeIntervalSince(date).truncate(places: 3)) second"
        }
    }
    
    func printCurrentTime() -> String {
        let currentDateTime = Date()

        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .short

        return formatter.string(from: currentDateTime)
    }
}

extension Double {
    func truncate(places: Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
