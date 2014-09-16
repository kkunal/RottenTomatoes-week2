//
//  MovieDetailViewController.swift
//  RottenTomatoes-week2
//
//  Created by Kunal Kshirsagar on 9/15/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieTitle: String = ""
    var movieDescription: String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var largeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.movieTitle)
        println(self.movieDescription)
        if((titleLabel) != nil) {
            titleLabel.text = NSString(string: self.movieTitle)
        }
        if((largeImageView) != nil) {
            largeImageView.setImageWithURL(NSURL(string: NSString(string: self.movieDescription)))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
