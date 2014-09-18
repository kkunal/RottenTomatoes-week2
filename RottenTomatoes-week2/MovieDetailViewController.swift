//
//  MovieDetailViewController.swift
//  RottenTomatoes-week2
//
//  Created by Kunal Kshirsagar on 9/15/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: NSDictionary!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var largeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.movie["title"] as? String
    //    println("received data: \(movie)")
        ProgressHUD.show("Fetching movie details..")
        self.loadMovieDetail()
       scrollView.contentSize = CGSize(width: synopsisLabel.frame.width, height: synopsisLabel.frame.height)
        titleLabel.text = NSString(string: self.movie["title"] as String)
        var posters = self.movie["posters"] as NSDictionary
        var posterUrl = posters["detailed"] as String
        posterUrl = posterUrl.stringByReplacingOccurrencesOfString("_tmb.jpg", withString: "_det.jpg")
    //    posterUrl.stringByReplacingCharactersInRange(, withString: <#String#>
        println("poster URL : \(posterUrl)")
        
        largeImageView.setImageWithURL(NSURL(string: NSString(string: posterUrl as String)))
        synopsisLabel.text = NSString(string: self.movie["synopsis"] as String)
        ProgressHUD.showSuccess("Successfully loaded movie details")
  }

    func loadMovieDetail()  {
        var movieId = self.movie["id"] as String
        var url = "http://api.rottentomatoes.com/api/public/v1.0/movies/" + movieId + ".json"
 //       println("api url: \(url)")
        var request = NSURLRequest(URL: NSURL(string: url))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if(data == nil) {
                //show the error label
                self.errorLabel.alpha = 1
                println("error in geting movie details")
                ProgressHUD.dismiss()
                ProgressHUD.showError("Couldn't fetch movie details")
            } else {
                //hide the error label
                self.errorLabel.alpha = 0
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movie = object
                ProgressHUD.showSuccess("successfully fetched movie details")
             }
        }
     //   return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
     //   ProgressHUD.show("Showing movie details..")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println(sender)
    }
    */

}
