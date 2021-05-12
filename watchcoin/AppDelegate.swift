//
//  AppDelegate.swift
//  watchcoin
//
//  Created by 二锅头 on 2021/5/11.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: 88)
    
    weak var timer: Timer?
    var button: NSStatusBarButton?
    
    func getData() {
        let session = URLSession.shared
        let url = URL(string: "https://api.huobi.pro/market/trade?symbol=ethusdt")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                // TODO
                return
            }
            do {
                let ret = try JSONDecoder().decode(HuobiResp.self, from: data!) as? HuobiResp
//                var dict = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(ret?.tick.data[0].price)
                self.button?.title = String(format: "%.1f", ret!.tick.data[0].price)
            } catch {
                // TODO
            }
        })
        task.resume()
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] _ in
            self?.getData()
        })
        timer?.fire()
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        button = statusItem.button
        button?.title = "ETH -> USDT"
        self.startTimer()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        stopTimer()
    }

}

