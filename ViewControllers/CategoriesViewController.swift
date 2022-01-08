//
//  CategoriesViewController.swift
//  RandomMovieSelector
//
//  Created by gizem.kaya on 26.12.2021.
//

import UIKit

class CategoriesViewController: UIViewController{
    
    
    
    @IBOutlet weak var CategoryTable: UITableView!
    let categoryDataSource = MovieData()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        categoryDataSource.loadCategoryList()
        categoryDataSource.delegate = self
        
        // Do any additional setup after loading the view.
        
        self.title = "Categories"
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         let cell = sender as! CategoryTableViewCell
         if  let indexPath = self.CategoryTable.indexPath(for: cell) {
             let category = categoryDataSource.getCategoryForIndex(index: indexPath.row)
             let MoviesViewController = segue.destination as! MoviesViewController
             MoviesViewController.selectedCategory = category
     }
     
    
}
}

extension CategoriesViewController: MovieDataDelegate{
    
    func CategoryListLoaded() {
        CategoryTable.reloadData()
    }
    
    func MovieListLoaded() {
        
    }
    
    func MovieDetailLoaded() {
        
    }
    
}


extension CategoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDataSource.getNumberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        let category = categoryDataSource.getCategoryForIndex(index: indexPath.row)
        cell.CategoryLabel.text = category
        return cell
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("Begin dragging")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("End dragging")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("Stopped")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (velocity.y > 0) {
            let yOffset = targetContentOffset.pointee.y
            let remainder = yOffset.truncatingRemainder(dividingBy: 88.5)
            targetContentOffset.pointee.y -= remainder
        }
    }
}
