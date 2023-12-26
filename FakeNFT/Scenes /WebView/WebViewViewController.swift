//
//  WebViewViewController.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 12.12.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    //MARK: - Layout variables
    private lazy var backButton: UIButton = {
        let imageButton = UIImage(named: "backward")?.withRenderingMode(.alwaysTemplate)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(imageButton, for: .normal)
        button.tintColor = UIColor.ypBlackDay
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        return button
    }()
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    //MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://practicum.yandex.ru/") {
            webView.navigationDelegate = self
            webView.load(URLRequest(url: url))
        }
        
        setupView()
    }
}

//MARK: - Privtae functions
extension WebViewViewController {
    func setupView() {
        view.backgroundColor = .ypWhiteDay
        
        addSubViews()
        configureConstraints()
    }
    
    func addSubViews() {
        view.addSubview(backButton)
        view.addSubview(webView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 9),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - WKNavigationDelegate
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIBlockingProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIBlockingProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        assertionFailure("Webview failed with error: \(error.localizedDescription)")
        UIBlockingProgressHUD.dismiss()
    }
}