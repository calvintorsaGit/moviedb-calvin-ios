//
//  CustomDetailMovieViewController.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class CustomDetailMovieViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    
    var movie:Movie?
    private let headerCellId = "HeaderDetailTableViewCell"
    private let reviewCellId = "ReviewTableViewCell"
    private let viewModel = DetailViewModel()
    private var currentPage = 1
    private let spinner = UIActivityIndicatorView(style: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        bindData()
    }
    
    private func initView()  {
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        self.detailTableView.register(UINib(nibName: "HeaderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellId)
        self.detailTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: reviewCellId)
        
        //init loading spinner for endless scroll
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        self.detailTableView.tableFooterView = spinner
        
        self.loadFirstTime()
    }
    
    private func bindData(){
        self.viewModel.reloadData = {
            [weak self] in
            DispatchQueue.main.async {
                self?.detailTableView.reloadData()
            }
        }
        
        self.viewModel.stopLoading = {
            loading in
            DispatchQueue.main.async {
                if(loading != false){
                    self.spinner.stopAnimating()
                }
            }
        }
        
        self.viewModel.youtubeVideo = {
            url in
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
                vc.urlYoutube = url
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    
    // function to load tableview first time
    private func loadFirstTime(){
        self.currentPage = 1
        self.viewModel.getReview(movie_id: movie?.id ?? 0, page: currentPage)
    }
    
    
}

extension CustomDetailMovieViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + viewModel.review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.item == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! HeaderDetailTableViewCell
            cell.watchTrailerOnClick = {
                [weak self] in
                self?.viewModel.getYoutube(movie_id: self!.movie?.id ?? 0)
            }
            cell.initData(movie: movie!)
            return cell
        }else if (indexPath.item == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "reviewHeaderCell") 
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: reviewCellId) as! ReviewTableViewCell
            cell.setData(review: self.viewModel.review[indexPath.item - 2])
            return cell
        }
        
    }
    
    //delegate to handle endless scroll and load next page
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.viewModel.loading == false{
            if indexPath.row + 1 == self.viewModel.review.count {
                self.spinner.startAnimating()
                self.currentPage += 1
                self.viewModel.getReview(movie_id: movie?.id ?? 0, page: currentPage)
            }
        }
    }
    
    
}


