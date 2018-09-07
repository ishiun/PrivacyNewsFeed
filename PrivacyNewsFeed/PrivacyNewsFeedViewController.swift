//
//  PrivacyNewsFeedViewController.swift
//  PrivacyNewsFeed
//
//  Created by I-Shiun Kuo on 9/7/18.
//  Copyright © 2018 I-Shiun Kuo. All rights reserved.
//

import UIKit

class PrivacyNewsFeedViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var newsFeed: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedTableView.dataSource = self
        
        let url = URL(string: "http://privacy.apievangelist.com/apis/news/")
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let newsFeed = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                self.newsFeed = newsFeed
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsFeedTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
