//
//  CategoryViewController.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 18/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    @IBOutlet weak var tableViewCategory: UITableView!
    
    //temp variable
    private let genreViewModel = GenreViewModel()
    private let reuseIdentiferCategory = "CategoryViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        bindData()
        
    }
    
    private func initView()  {
        self.navigationItem.title = "Temukan Film berdasarkan genre"
        self.tableViewCategory.dataSource = self
        self.tableViewCategory.delegate = self
        self.tableViewCategory.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentiferCategory)
        self.genreViewModel.getGenre()
    }
    
    private func bindData()  {
        self.genreViewModel.reloadData = {
            [weak self] in
            DispatchQueue.main.async {
                self?.tableViewCategory.reloadData()
            }
        }
    }
    
}

extension GenreViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genreViewModel.genre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewCategory.dequeueReusableCell(withIdentifier: self.reuseIdentiferCategory, for: indexPath) as! CategoryViewCell
        cell.setData(self.genreViewModel.genre[indexPath.item].name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListMovieViewController") as! ListMovieViewController
        vc.genre = self.genreViewModel.genre[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


