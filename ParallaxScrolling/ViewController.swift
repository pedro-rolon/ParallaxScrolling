//
//  ViewController.swift
//  ParallaxScrolling
//
//  Created by Pedro Rolon on 2020-12-06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titles = ["Princesa", "Linda", "Hermosa", "Bella", "Tierna", "Preciosa"]
    
    var images: [UIImage] = [
        UIImage(named: "image-1")!,
        UIImage(named: "image-2")!,
        UIImage(named: "image-3")!,
        UIImage(named: "image-4")!,
        UIImage(named: "image-5")!,
        UIImage(named: "image-6")!,
    ]
    
    var parallaxOffsetSpeed: CGFloat = 100
    var cellHeight: CGFloat = 250
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * tableView.frame.height) - cellHeight ) / 2
        
        return maxOffset + cellHeight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollViewDidScroll(tableView)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollViewDidScroll(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as? ImageCell {
            
            cell.configureCell(title: titles[indexPath.row], image: images[indexPath.row])
            cell.parallaxImageHeight.constant = parallaxImageHeight
            cell.parallaxTopConstraint.constant = parallaxOffset(newOffsetY: tableView.contentOffset.y, cell: cell)
            
            return cell
        } else {
            return ImageCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func parallaxOffset(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        
        return(newOffsetY - cell.frame.origin.y) / parallaxImageHeight * parallaxOffsetSpeed
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [ImageCell] {
            cell.parallaxTopConstraint.constant = parallaxOffset(newOffsetY: offsetY, cell: cell)
        }
    }
}
