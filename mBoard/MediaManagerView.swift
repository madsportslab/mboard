//
//  MediaManagerView.swift
//  mBoard
//
//  Created by hu on 2/3/18.
//  Copyright © 2018 madsportslab. All rights reserved.
//

import UIKit

import Alamofire
import Font_Awesome_Swift
import SwiftWebSocket
import SwiftyJSON

class MediaManagerView: UIViewController, UITableViewDelegate, UITableViewDataSource,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let defaults = UserDefaults.standard
    let picker = UIImagePickerController()
    
    var ws = WebSocket()
    var media = [[String]]()
    
    var VIDEO_FORMATS = ["MOV", "MP4"]
    var AUDIO_FORMATS = ["AAC", "MP3", "M4A"]
    var PHOTO_FORMATS = ["JPEG", "JPG", "PNG"]
    
    // MARK: Properties
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var mediaTable: UITableView!
    @IBOutlet weak var mediaSegment: UISegmentedControl!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //uploadBtn.setFAIcon(icon: FAType.FACamera, iconSize: 64, forState: .normal)
        //uploadBtn.setFATitleColor(color: Mboard.TealColor)
        
        uploadBtn.layer.cornerRadius = 5
        uploadBtn.layer.borderColor = Mboard.TealColor.cgColor
        uploadBtn.layer.borderWidth = 1
        
        mediaTable.dataSource = self
        mediaTable.delegate = self
        
        picker.delegate = self
        
        initWS()
        loadMedia()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mediaTable.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! MediaCell
        
        cell.state.text = media[indexPath.item][3]
        
        cell.timestamp.layer.cornerRadius = 5
        cell.timestamp.layer.masksToBounds = true
        cell.timestamp.text = media[indexPath.item][1]
        
        cell.thumbnail.setFAIconWithName(icon: FAType.FAPictureO, textColor: .white)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var cmd = Mboard.WS_VIDEO_PLAY
        
        switch self.mediaSegment.selectedSegmentIndex {
        case 0:
            
            if media[indexPath.item][3] == Mboard.PLAYING {
                
                cmd = Mboard.WS_VIDEO_STOP
                media[indexPath.item][3] = Mboard.BLANK
                
            } else {
                
                cmd = Mboard.WS_VIDEO_PLAY
                media[indexPath.item][3] = Mboard.PLAYING
                
            }
            
        case 1:
            
            if media[indexPath.item][3] == Mboard.PLAYING {
                
                cmd = Mboard.WS_PHOTO_STOP
                media[indexPath.item][3] = Mboard.BLANK
                
            } else {
                
                cmd = Mboard.WS_PHOTO_PLAY
                media[indexPath.item][3] = Mboard.PLAYING
            
            }
            
            
        case 2:
            
            if media[indexPath.item][3] == Mboard.PLAYING {
                
                cmd = Mboard.WS_AUDIO_STOP
                media[indexPath.item][3] = Mboard.BLANK
                
            } else {
                
                cmd = Mboard.WS_AUDIO_PLAY
                media[indexPath.item][3] = Mboard.PLAYING
            
            }
            
            
        default:
            return
        }

        ws.send(JSON(
            [
                "cmd": cmd,
                "options": [
                    "key": media[indexPath.item][2]
                ]
            ]
        ))
        
        self.mediaTable.reloadData()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
       
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/media"
        
        print(info)
        
        let mediaType = info[UIImagePickerControllerMediaType] as? String
        
        if mediaType! == "public.movie" {

            let name = info[UIImagePickerControllerMediaURL] as? URL
            
            let ext = name!.pathExtension
            
            if supportedExtension(ext: ext) {
                
                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(name!, withName: "media")
                }, to: url, encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        upload.response{ response in
                            print(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                })
                
            } else {
                
                let ac = UIAlertController(title: "Format Error",
                                           message: "File format not supported: \(ext)",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                let OK = UIAlertAction(title: "OK",
                                       style: UIAlertActionStyle.default,
                                       handler: nil)
                
                ac.addAction(OK)
                
                self.present(ac, animated: true, completion: nil)
                
            }

            
        } else if mediaType! == "public.image"{

            let name = info[UIImagePickerControllerImageURL] as? URL
            
            let p = info[UIImagePickerControllerOriginalImage] as? UIImage

            //let ext = name!.pathExtension
            //let data = UIImageJPEGRepresentation(p!, 1.0)
            
            //if supportedExtension(ext: ext) {

              /*  Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(data!, withName: "media",
                        fileName: name!.lastPathComponent, mimeType: "image/jpg")
                }, to: url, encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        upload.response{ response in
                            print(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                })*/
            
                Alamofire.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(name!, withName: "media")
                }, to: url, encodingCompletion: { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        upload.response{ response in
                            print(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                })
                
            //} else {
                
              //  let ac = UIAlertController(title: "Format Error",
                  //                         message: "File format not supported: \(ext)",
                //    preferredStyle: UIAlertControllerStyle.alert)
                
                //let OK = UIAlertAction(title: "OK",
                  //                     style: UIAlertActionStyle.default,
                    //                   handler: nil)
                
                //ac.addAction(OK)
                
                //self.present(ac, animated: true, completion: nil)
                
            //}
            
        }
        
        /*
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data!, withName: "media", fileName: "", mimeType: "image/jpg")
        }, to: url, method: .post, header: [) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.response{ response in
                    print(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        */
        
        /*Alamofire.upload(data!, to: url).uploadProgress{ progress in
            print("uploaded \(progress.fractionCompleted)")
        }*/
        
        /*Alamofire.upload(
            multipartFormData: { multipartFormData in
              multipartFormData.append("test text", withName: "media")
        },
        to: url,
        encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):
                upload.response { resp in
                    debugPrint(resp)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })*/

        /*Alamofire.upload(
            multipartFormData: { multipartFormData in
              multipartFormData.append(chosenImage, withName: "media")
            },
            to: url,
            encodingCompletion: { result in
                switch result {
                case .success(let upload, _, _):
                    print("fag")
                case .failure:
                    print("shit")
                }
            }
        )*/
        
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func initWS() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        let url = "\(Mboard.WS)\(ed!)/ws/manager"
        
        ws = WebSocket(url)
        
        ws.event.close = { code, reason, clean in
            self.ws.open()
        }
        
        ws.event.open = {
            print("socket connected")
        }
        
        ws.event.error = { error in
            print(error)
        }
        
        ws.event.message = { message in
            
            if let txt = message as? String {
                
                let obj = JSON.init(parseJSON: txt)
                
                print(obj)
                
                /*switch obj["key"] {
                 case Mboard.WS_VIDEO:
                 
                 case Mboard.WS_PHOTO:
                 
                 case Mboard.WS_AUDIO:
                 
                 }*/
                
            }
        }
        
    } // initWS
    
    func supportedExtension(ext: String) -> Bool {
    
        let up = ext.uppercased()
        
        if VIDEO_FORMATS.contains(up) {
            return true
        } else if AUDIO_FORMATS.contains(up) {
            return true
        } else if PHOTO_FORMATS.contains(up) {
            return true
        }
        
        return false
        
    } // supportedExtension
    
    func loadMedia() {
        
        let ed = defaults.object(forKey: Mboard.SERVER) as? String
        
        let url = "\(Mboard.HTTP)\(ed!)/api/media"
        
        self.progress.startAnimating()
        
        Alamofire.request(url, method: .get)
            .responseJSON{ response in
                
                switch response.result {
                case .failure(let error):
                    
                    let ac = UIAlertController(title: "Connection error",
                                               message: error.localizedDescription,
                                               preferredStyle: UIAlertControllerStyle.alert)
                    
                    let OK = UIAlertAction(title: "OK",
                                           style: UIAlertActionStyle.default,
                                           handler: nil)
                    
                    ac.addAction(OK)
                    
                    self.present(ac, animated: true, completion: nil)
                    
                    
                case .success:
                    
                    if let raw = response.result.value {
                        
                        let j = JSON(raw)
                        
                        print(j)
                        
                        var str = "VIDEO"
                        
                        if self.mediaSegment.selectedSegmentIndex == 1 {
                            str = "PHOTO"
                        } else if self.mediaSegment.selectedSegmentIndex == 2 {
                            str = "AUDIO"
                        }
                        
                        var am = [[String]]()
                        
                        for (_, v) in j {
                        
                            if str == v["tag"].string! {

                                var m = [String]()
                                
                                let f = DateFormatter()
                                
                                f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                                
                                let d = f.date(from: v["created"].string!)
                                
                                let f2 = DateFormatter()
                                
                                f2.dateFormat = "MMM d, yyyy HH:mm"
                                
                                let d2 = f2.string(from: d!)
                                
                                m.append(v["tag"].string!)
                                m.append(d2)
                                m.append(v["key"].string!)
                                m.append("") // this is for the status label
                                
                                am.append(m)

                            }
                            
                        }
                        
                        self.media = am
                        
                        print(self.media)
                        
                        self.mediaTable.reloadData()
                    
                    }
                    
                    self.progress.stopAnimating()
                    
                }
         
                
                
        }
        
    } // loadMedia
    
    // MARK: Actions
    
    @IBAction func chooseMedia(_ sender: Any) {
        loadMedia()
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
    }
    
    
} // MediaManagerView

