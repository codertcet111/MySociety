//
//  EventDetailViewController.swift
//  MySociety
//
//  Created by Admin on 12/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EventDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDetailPhotoGalleryCollectionView: UICollectionView!
    
    @IBOutlet weak var eventDetailDescriptionText: UILabel!
    
    @IBOutlet weak var eventDetailGalleryCOllectionViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var eventDetailLAbelTopConstraints: NSLayoutConstraint!
    var selectedEventId: Int = 1
    var eventDetailModelObject: eventDetailModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventDetailDescriptionText.text = "We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year. We will be having the birthday celebration for Anmol. He will be the morgan boy of the year. Lets celbrate his birthday for this year."
        self.animateView()
        getEventDetailData()
    }
    
    func getEventDetailData(){
//        showSpinner(onView: self.view)
        let headerValues = globalHeaderValue
        let request = getRequestUrlWithHeader(url: "eventdetail/\(selectedEventId)", method: "GET", header: headerValues , bodyParams: nil)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//            self.removeSpinner()
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(String(describing: strData))")
                
                if(response != nil && data != nil){
                    switch  httpResponse?.statusCode {
                    case 200:
                        self.eventDetailModelObject = try? JSONDecoder().decode(eventDetailModel.self,from: data!)
                            DispatchQueue.main.sync {
                                self.eventTitleLabel.text = self.eventDetailModelObject?.eventDetailData.title ?? ""
                                self.eventDetailDescriptionText.text = "Detail: \(self.eventDetailModelObject?.eventDetailData.description ?? "")"
                                self.eventDetailPhotoGalleryCollectionView.reloadData()
                            }
                    case 401:
                        DispatchQueue.main.sync {
                            self.showAlert("Unauthorized User")
                        }
                    default:
                        DispatchQueue.main.sync {
                            self.showAlert("something Went Wrong Message")
                        }
                    }
                }else{
                    self.showAlert("No data!")
                }
            }
        })
        dataTask.resume()
    }
    
    func showAlert(_ message: String) -> (){
           let alert = UIAlertController(title: message, message: nil , preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { _ in
            self.getEventDetailData()
           }))
           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
           }))
           self.present(alert, animated: true, completion: nil)
       }
    
    func animateView(){
        eventTitleLabel.font = eventTitleLabel.font.withSize(50)
        eventTitleLabel.font = eventTitleLabel.font.withSize(17)
        eventDetailGalleryCOllectionViewHeightConstraints.constant = 0
        eventDetailGalleryCOllectionViewHeightConstraints.constant = 300
        eventDetailLAbelTopConstraints.constant = 600
        eventDetailLAbelTopConstraints.constant = 34
        UIView.animate(withDuration: 1.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventDetailImageGalleryCollectionViewCell", for: indexPath) as! EventDetailImageGalleryCollectionViewCell
            Alamofire.request("\(self.eventDetailModelObject?.imageRootUrl ?? "")/\(self.eventDetailModelObject?.eventDetailData.imageUrl ?? "")")
            .responseImage { response in

                if let image = response.result.value {
                    cell.eventDetailCollectionViewCellImageView?.image = image
                }
            }
    //        cell.cellBackgroundView.layer.cornerRadius = 10.0
            return cell
        }

}
