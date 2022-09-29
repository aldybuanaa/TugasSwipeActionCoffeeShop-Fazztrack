//
//  CoffeeShopListViewController.swift
//  Kopi Surgawi
//
//  Created by aldybuana on 19/09/22.
//

import UIKit

class CoffeeShopListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Data dummy
    var coffeeshops: [Coffeeshop] = [
        Coffeeshop(name: "Boja Eatery", type: "Coffeeshop / Cafe", location: "Jl. Pungkur", image: "bojaeatery", isFavorite: false),
                
        Coffeeshop(name: "Brewery Coffee", type: "Tea House", location: "Jl. Buahbatu", image: "brewery", isFavorite: false),
                
        Coffeeshop(name: "Casadela Coffee", type: "Cafe Shop", location: "Jl. Asia Afrika", image: "casadela", isFavorite: false),
                
        Coffeeshop(name: "Dago Terrace", type: "Home Coffee", location: "Jl. Sudirman", image: "dagoterrace", isFavorite: false),
                
        Coffeeshop(name: "Hola Koffie", type: "Coffeeshop / Cafe", location: "Jl. Setiabudi", image: "holakoffie", isFavorite: false),
                
        Coffeeshop(name: "Imah Kai", type: "Tea House", location: "Jl. Boscha", image: "imahkai", isFavorite: false),
                
        Coffeeshop(name: "Jiwan Kopi", type: "Cafe", location: "Jl. Sukabumi", image: "jiwan", isFavorite: false),
                
        Coffeeshop(name: "Kilogram Space", type: "Home Coffee", location: "Jl. Soekarno Hatta", image: "kilogram", isFavorite: false),
                
        Coffeeshop(name: "Masagi Coffee", type: "Bakery / Cafe", location: "Jl. Kopo", image: "masagi", isFavorite: false),
                
        Coffeeshop(name: "Nannys Pavillion", type: "Tea House / Cafe", location: "Jl. Dago", image: "nannys", isFavorite: false),
                
        Coffeeshop(name: "Sabana Kopi", type: "Coffeeshop / Bakery", location: "Jl. Cibiru", image: "sabanakopi", isFavorite: false),
                
        Coffeeshop(name: "Sini Kupi", type: "Coffeeshop / Milk House", location: "Jl. Aceh", image: "sinikupi", isFavorite: false),
                
        Coffeeshop(name: "Sonowae Kopi", type: "Coffeeshop / Cafe", location: "Jl. Cihapit", image: "sonowae", isFavorite: false),
                
        Coffeeshop(name: "Starbuck Coffee", type: "Bakery", location: "Jl. Gandapura", image: "starbuck", isFavorite: false),
                
        Coffeeshop(name: "Urra Cafe", type: "Warmindo", location: "Jl. Riau", image: "urracafe", isFavorite: false)
    ]
//    var favoritedCoffeeshops: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeshops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeShopCellId", for: indexPath) as! CoffeeShopViewCell
        
        let coffeeshop = coffeeshops[indexPath.row]
        
        // Jika gambar tidak ada atau nil, akan memuat gambar placeholder
        if let image = coffeeshop.image {
            cell.thumbImageView.image = UIImage(named: image)
        } else {
            cell.thumbImageView.image = UIImage(systemName: "photo")
        }
        
        cell.nameLabel.text = coffeeshop.name
        cell.addressLabel.text = coffeeshop.location
        cell.categoryLabel.text = coffeeshop.type
        
        // Jika cell di favorite akan muncul icon heart, jika di unfavorite akan menyembunyikan icon heart
        if coffeeshop.isFavorite {
            cell.thumbFavorited.isHidden = false
        }
        else {
            cell.thumbFavorited.isHidden = true
        }
        
        return cell
    }
    // MARK: - Helper Functions
   
    
    func reserveTable(_ index: Int){
        let alert = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. \nPlease try again later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    /*
    func isFavorited(_ index: Int) -> Bool {
//        return favoritedCoffeeshops.contains(where: { item in
//            return item == index
//        })
        return favoritedCoffeeshops.contains(where: { $0 == index })
    }
     */
    
    // function untuk menambahkan favorite atau menghapus favorite
    func toggleFavorite(_ index: Int){
       
        if coffeeshops[index].isFavorite {
            coffeeshops[index].isFavorite = false
        } else {
            coffeeshops[index].isFavorite = true
        }
        
        //tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableView.RowAnimation.automatic)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Reserve a table", style: UIAlertAction.Style.default, handler: { alert in
            self.reserveTable(indexPath.row)
        }))
        
        // Jika row dalam keadaan favorited, title akan bertuliskan "Remove from favorite"
        if coffeeshops[indexPath.row].isFavorite {
            actionSheet.addAction(UIAlertAction(title: "Remove from favorite", style: .default, handler: { _ in
                self.toggleFavorite(indexPath.row)
            }))
        }
        // Jika row dalam keadaan unfavorited, title akan bertuliskan "Mark as favorite"
        else {
            actionSheet.addAction(UIAlertAction(title: "Mark as favorite", style: .default, handler: { _ in
                self.toggleFavorite(indexPath.row)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        
        present(actionSheet, animated: true)
        
    }
  

    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//        case .delete:
//            coffeeshops.remove(at: indexPath.row)
////            coffeeshopNames.remove(at: indexPath.row)
////            coffeeshopTypes.remove(at: indexPath.row)
////            coffeeshopLocations.remove(at: indexPath.row)
////            coffeeshopImage.remove(at: indexPath.row)
//
////            if let index = favoritedCoffeeshops.firstIndex(where: { item in return item == indexPath.row}) {
////                favoritedCoffeeshops.remove(at: index)
////            }
//
//
//
//        default:
//            break
//        }
//    }
    
    // function untuk menghapus row
    func delete(at indexPath: IndexPath) {
        coffeeshops.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }

    // function untuk share informasi row ke aplikasi lain
    func share(at indexPath: IndexPath) {
        let coffeeshops = coffeeshops[indexPath.row]
        
        let name = coffeeshops.name ?? ""
        print(name)
        
        let image: UIImage
        if let imageName = coffeeshops.image {
            image = UIImage(named: imageName) ?? UIImage(systemName: "photo")!
        } else {
            image = UIImage(systemName: "photo")!
        }
        
        let url = URL(string: "https://fazztrack.com")!
        
        let viewController = UIActivityViewController(activityItems: [name, image, url], applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = view
        present(viewController, animated: true)
    }
    
    // function untuk membuat swipe action dari kanan ke kiri
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: UIContextualAction.Style.destructive, title: "delete") { action, view, completion in
            
            self.delete(at: indexPath)
            completion(true)
        }
        delete.image = UIImage(systemName: "trash")
        
        let share = UIContextualAction(style: .normal, title: "Share"){ _, view, completion in
            self.share(at: indexPath)
            completion(true)
        }
        share.image = UIImage(systemName: "square.and.arrow.up")
        share.backgroundColor = UIColor.systemBlue
        
        let actions = UISwipeActionsConfiguration(actions: [delete, share])
        actions.performsFirstActionWithFullSwipe = false
        
        return actions
    }
    
    // function untuk membuat swipe action dari kiri ke kanan
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: UIContextualAction.Style.normal, title: nil) { action, view, completion in
            
            self.toggleFavorite(indexPath.row)
            completion(true)
        }
        
        if coffeeshops[indexPath.row].isFavorite {
            favorite.image = UIImage(systemName: "heart.slash.fill")
        }
        else {
            favorite.image = UIImage(systemName: "heart.fill")
        }
        
        
        favorite.backgroundColor = UIColor.systemYellow
        
        let actions = UISwipeActionsConfiguration(actions: [favorite])
        return actions
    }
    
}
