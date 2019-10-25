//
//  movieGridViewController.swift
//  Flix
//
//  Created by Kevin Denis on 10/25/19.
//  Copyright © 2019 Kevin Denis. All rights reserved.
//

import UIKit
import AlamofireImage

class movieGridViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
        
    
    @IBOutlet var moviesGrid: UICollectionView!
    
    
    var movies = [[String : Any]]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesGrid.dataSource = self
        moviesGrid.delegate = self
        
        let layout =
            moviesGrid.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)/3
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.estimatedItemSize = CGSize(width: 0, height: 0)

         let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
               let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
               let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
               let task = session.dataTask(with: request) { (data, response, error) in
                   // This will run when the network request returns
                   if let error = error {
                       print(error.localizedDescription)
                   } else if let data = data {
                       let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                       
                       self.movies = dataDictionary["results"] as! [[String:Any]]
                    
                       self.moviesGrid.reloadData()
                   }
               }
             task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell = moviesGrid.dequeueReusableCell(withReuseIdentifier: "movieGridCell", for: indexPath) as! movieGridCell
               
               let movie = self.movies[indexPath.item]
               let baseURL = "https://image.tmdb.org/t/p/w185"
               let posterURL = movie["poster_path"] as! String
               let fullURL = URL(string: baseURL + posterURL)!
               
               cell.collectionViewPoster.af_setImage(withURL: fullURL)
              
               
               return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
