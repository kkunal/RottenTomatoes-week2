//
//  MoviesViewController.swift
//  RottenTomatoes-week2
//
//  Created by Kunal Kshirsagar on 9/15/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    var movies: [NSDictionary] = []
    var refreshControl: UIRefreshControl!
    var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us"
    @IBAction func onTap(sender: AnyObject) {
        
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh..")
        self.refreshControl.addTarget(self, action: "loadMovies:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        ProgressHUD.show("Loading movies...")
        loadMovies()
    }
    
    func loadMovies() {
        ProgressHUD.show("Loading movies..")
        var request = NSURLRequest(URL: NSURL(string: self.url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            self.refreshControl.endRefreshing()
            if(data == nil) {
                //show the error label
                self.errorLabel.alpha = 1
                ProgressHUD.showError("Couldn't fetch movies list")
            } else {
                //hide the error label
                self.errorLabel.alpha = 0
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
        //        println(object)
                self.movies = object["movies"] as [NSDictionary]
                ProgressHUD.showSuccess("successfully fetched movie list")
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //    println("Hello, I'm row: \(indexPath.row), section: \(indexPath.section)")
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
      //  println("clicked on row \(indexPath.row)")
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        cell.movieImageView.setImageWithURL(NSURL(string: posterUrl))
        
       // cell.frame.height = 100
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
        
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var movieDesController = segue.destinationViewController as MovieDetailViewController
        //get the selected row
        var indexPath = self.tableView.indexPathForSelectedRow()
        var movieDetails = self.movies[indexPath!.row]
  //      println("sending object : \(movieDetails)")
        movieDesController.movie = movieDetails
    }
    

}
