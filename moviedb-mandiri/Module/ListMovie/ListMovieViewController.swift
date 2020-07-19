//
//  ListMovieViewController.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class ListMovieViewController: UIViewController {
    
    @IBOutlet weak var movieTableView: UITableView!
    private var refreshControl = UIRefreshControl()
    private let spinner = UIActivityIndicatorView(style: .gray)
    
    //temp var
    var genre:Genre?
    var listMoviewViewModel = ListViewModel()
    private let movieCellIdentifier = "MovieViewCell"
    private var currentPage = 1
    private var isLoading = false
    
    override func viewWillAppear(_ animated: Bool) {
        initView()
        bindData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func initView()  {
        self.navigationItem.title = "Genre \(self.genre?.name ?? "")"
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieTableView.register(UINib(nibName:movieCellIdentifier, bundle: nil), forCellReuseIdentifier: movieCellIdentifier)
        
        //init refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.movieTableView.addSubview(refreshControl)
        
        //init loading spinner for endless scroll
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        self.movieTableView.tableFooterView = spinner
        
        //called once when vc iniated
        self.loadFirstTime()
        
    }
    
    func bindData()  {
        self.listMoviewViewModel.reloadData = {
            [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.spinner.stopAnimating()
            }
        }
    }
    
    //func called when pull to refresh is shown
    @objc func refresh(_ sender: AnyObject) {
        loadFirstTime()
    }
    
    
    // function to load tableview first time
    private func loadFirstTime(){
        self.currentPage = 1
        self.listMoviewViewModel.getMovieByGenre(page: self.currentPage, genre_id: self.genre?.id ?? 0)
    }
    
    
}

extension ListMovieViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listMoviewViewModel.movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieViewCell
        cell.setView(movie: self.listMoviewViewModel.movies[indexPath.item])
        return cell
    }
    
    //delegate to handle endless scroll and load next page
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.listMoviewViewModel.loading == false{
            if indexPath.row + 1 == self.listMoviewViewModel.movies.count && self.listMoviewViewModel.movies.count >= 5 {
                self.spinner.startAnimating()
                self.currentPage += 1
                self.listMoviewViewModel.getMovieByGenre(page: self.currentPage, genre_id: self.genre?.id ?? 0)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CustomDetailMovieViewController") as! CustomDetailMovieViewController
        vc.movie = self.listMoviewViewModel.movies[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
