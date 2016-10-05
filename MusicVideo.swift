//
//  MusicVideo.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 13/03/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    // data Encapsulation
    fileprivate var _vName:String
    fileprivate var _vRights:String
    fileprivate var _vPrice:String
    fileprivate var _vImageUrl:String
    fileprivate var _vArtist:String
    fileprivate var _vVideoUrl:String
    fileprivate var _vImid:String
    fileprivate var _vGenre:String
    fileprivate var _vLinkToiTunes:String
    fileprivate var _vReleaseDte:String
    
    // This variable gets created from the UI
    var vImageData:Data?
    
    
    // Make a getter
    var vName: String{
        return _vName
    }
    var vRights: String{
        return _vRights
    }
    var vPrice: String{
        return _vPrice
    }
    var vImageUrl: String{
        return _vImageUrl
    }
    var vArtist: String{
        return _vArtist
    }
    var vVideoUrl: String{
        return _vVideoUrl
    }
    var vImid: String{
        return _vImid
    }
    var vGenre: String{
        return _vGenre
    }
    var vLinkToiTunes: String{
        return _vLinkToiTunes
    }
    var vReleaseDate: String{
        return _vReleaseDte
    }
    
    
    
    init(data:JSONDictionary){
        
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String{
            self._vName = vName
        }else{
        _vName = ""
        }
        
        if let rights = data["rights"] as? JSONDictionary,
        let vRights = rights["label"] as? String{
        self._vRights = vRights
        }else{
        _vRights = ""
        }
        
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String{
            self._vPrice = vPrice
        }else{
        _vPrice = ""
        }
        
        if let img = data["im:image"] as? JSONArray, // datayı al
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String{
                _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600") // 100x100 olan resmi 600 600 yap
        }else{
            _vImageUrl = ""
        }
        
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String{
            self._vArtist = vArtist
        }else{
            _vArtist = ""
        }
        
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String{
            _vVideoUrl = vVideoUrl
        }else{
        _vVideoUrl = ""
        }
        
        // The Artist ID for iTunes Search API
        if let imid = data["id"] as? JSONDictionary,
            let vid = imid["attributes"] as? JSONDictionary,
            let vImid = vid["im:id"] as? String {
                self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }
        
        
        // The Genre
        if let genre = data["category"] as? JSONDictionary,
            let rel2 = genre["attributes"] as? JSONDictionary,
            let vGenre = rel2["term"] as? String {
                self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }
        
        
        // Video Link to iTunes
        if let release2 = data["id"] as? JSONDictionary,
            let vLinkToiTunes = release2["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        
        
        // The Release Date
        if let release2 = data["im:releaseDate"] as? JSONDictionary,
            let rel2 = release2["attributes"] as? JSONDictionary,
            let vReleaseDte = rel2["label"] as? String {
                self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = ""
        }
    }
    
}
