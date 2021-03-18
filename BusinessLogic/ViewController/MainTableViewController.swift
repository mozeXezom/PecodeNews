//
//  ViewController.swift
//  pecodeNewsApplication
//
//  Created by mozeX on 17.03.2021.
//

import UIKit

class MainTableViewController: UITableViewController, CloseViewDelegate {

    // MARK: - Public
    var news: [Response.News] = []
    var fullNewsView = FullNewsView(frame: CGRect(x: 0, y: -10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5))
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorColor = UIColor.clear
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 100
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        fullNewsView.delegate = self
        
        //Get news via Interactor
        DispatchQueue.global(qos: .default).async { [weak self] in
            self?.getNews()
        }

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! NewsTableViewCell
        
        cell.setup(item: news, indexPath:indexPath.row)
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsDescription = news[indexPath.row].description ?? ""
        let newsImageUrl = news[indexPath.row].urlToImage ?? ""
        
        fullNewsView.newsTextLabel.text = newsDescription
        fullNewsView.showImage(from: newsImageUrl)
        
        self.view.addSubview(fullNewsView)
    }

    
    // MARK: - Methods
    
    // MARK: Get News via Interactor method
    func getNews() {
        Interactor.getLentaFromApi() { [weak self] response in
            self?.news = response
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: Show Full View always on top when scrolled method
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newFrame = fullNewsView.frame
        newFrame.origin.x = 0
        newFrame.origin.y = self.tableView.contentOffset.y
        fullNewsView.frame = newFrame
    }
    
    
    
    // MARK: - Full News View Delegate method
    func closeFullViewButtonClicked(sender: UIButton) {
        
        fullNewsView.removeFromSuperview()
        
    }
    
    
}
