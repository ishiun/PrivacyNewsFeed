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
        self.newsFeedTableView.rowHeight = 200.0

        let api_key = "d67b00c3969f4a4b82bd0de3c4e234cf"
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=" + api_key)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let newsFeed = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                self.newsFeed = newsFeed["articles"] as! [[String : Any]]
                self.newsFeedTableView.reloadData()
            }
        }
        task.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsFeedTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        let news = self.newsFeed[indexPath.row]
        let title = news["title"] as! String
        let source = news["source"] as! [String:Any]
        let domain = source["name"] as! String
        let description = news["description"] as! String
        let date = news["publishedAt"] as! String
        let author = news["author"] as! String
        let imageUrlString = news["urlToImage"] as! String
        let imageUrl = URL(string: imageUrlString)
        
        let data = try? Data(contentsOf: imageUrl!)
        cell.posterImageView.image = UIImage(data: data!)
        
        
        cell.titleLabel.text = title
        cell.sourceLabel.text = domain
        cell.descriptionLabel.text = description
        cell.dateLabel.text = date
        cell.authorLabel.text = author
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
