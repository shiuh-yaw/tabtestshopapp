//
//  SecondViewController.swift
//  tabtestshopapp
//
//  Created by Shiuh Yaw Phang on 17/10/19.
//  Copyright © 2019 Shiuh Yaw Phang. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var currentURLString = ""
    
    @IBOutlet weak var zhBtn: UIButton!
    @IBOutlet weak var enBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let urlString = "https://hsbc-uat.au.auth0.com/authorize?scope=profile.ecommerce.read openid&response_type=code&client_id=to5rs80ULPXyqjGj33FTQF4oO1Ts8DwA&redirect_uri=https://choices.cxapalawanuat.com/sso/login?langid=en-HK&protocol=oauth2&connection=hsbc-uat&prompt=login&audience=https://choices.cxapalawanuat.com"
        if let url = URL(string: urlString.encodeUrl()!) {
            let request = URLRequest(url: url)
            webView.load(request)
            
        }
        webView.allowsBackForwardNavigationGestures = true
        
        let enBtn = UIButton(type: .system) as UIButton
        
        let xPostion:CGFloat = 50
        let yPostion:CGFloat = 100
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 45
        
        enBtn.frame = CGRect(x:xPostion, y:yPostion, width:buttonWidth, height:buttonHeight)
        
        enBtn.backgroundColor = UIColor.lightGray
        enBtn.setTitle("For English", for: .normal)
        enBtn.tintColor = UIColor.black
        enBtn.addTarget(self, action: #selector(enBtnAction(_:)), for: .touchUpInside)
        
        self.view.addSubview(enBtn)
        
        let zhBtn = UIButton(type: .system) as UIButton
        
        let x1Postion:CGFloat = 220
        let y1Postion:CGFloat = 100
        let buttonWidth1:CGFloat = 150
        let buttonHeight1:CGFloat = 45
        
        zhBtn.frame = CGRect(x:x1Postion, y:y1Postion, width:buttonWidth1, height:buttonHeight1)
        
        zhBtn.backgroundColor = UIColor.blue
        zhBtn.setTitle("For Tr Chinese", for: .normal)
        zhBtn.tintColor = UIColor.black
        zhBtn.addTarget(self, action: #selector(zhBtnAction(_:)), for: .touchUpInside)
        
        self.view.addSubview(zhBtn)

        
    }
    
    @IBAction func enBtnAction(_ sender: UIButton) {
        
        var appendString = ""
        if currentURLString.count > 0 {
            if currentURLString.contains("?") {
                appendString = "&langid=en-HK"
            } else {
                appendString = "?langid=en-HK"
            }
        }
        currentURLString.append(appendString)
        if let url = URL(string: currentURLString.encodeUrl()!) {
            let request = URLRequest(url: url)
            webView.load(request)
            
        }
    }
    
    @IBAction func zhBtnAction(_ sender: UIButton) {
        
        var appendString = ""
        if currentURLString.count > 0 {
            if currentURLString.contains("?") {
                appendString = "&langid=zh-HK"
            } else {
                appendString = "?langid=zh-HK"
            }
        }
        currentURLString.append(appendString)
        if let url = URL(string: currentURLString.encodeUrl()!) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.previousFailureCount > 0 {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        } else if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
        } else {
            print("unknown state. error: \(String(describing: challenge.error))")
            // do something w/ completionHandler here
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("URL: \(webView.url!.absoluteString)")
        currentURLString = webView.url!.absoluteString
        decisionHandler(.allow)
    }
    
}

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
