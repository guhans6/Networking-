import Foundation


struct Parameters: Encodable {
    let autorename: Bool
    let path: String
}

func createFolder() {
    
    let url = "https://api.dropboxapi.com/2/files/create_folder_v2"
    
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.setValue("Bearer sl.BVSGb9zDxTnRjdpVmwj_aiS8EXFcqtpogYKjPT82iIerwBsgHGCpdL0EsWMr338CRVw0FEeO8kapS839NbNpwCwhIQIC0AFZgXzvxV-5c-84XoQAKIv6IBDCNHPuYZrXWvARRmlDLI8H", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    let parameters = Parameters(autorename: false, path: "/O/S")
    let body = try! JSONEncoder().encode(parameters)
    request.httpBody = body
//    print(String(decoding: request.httpBody!, as: UTF8.self))
    let task = session.dataTask(with: request) { data, response, error in
        print("hmmm")
        if let error = error {
            print("Error ", error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("Not a good response")
            return
        }
        
        if !(200 ... 299).contains(response.statusCode) {
            print("Status not Ok")
            print(response.statusCode)
            return
        }
        
        guard let data = data else {
            print("No data returned")
            return
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data)
            print(result)
        } catch {
            print(error)
        }
        
        
    }
    task.resume()
}

func deleteFolder() {
    let url = "https://api.dropboxapi.com/2/files/delete_v2"
    
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    request.setValue("Bearer sl.BVSGb9zDxTnRjdpVmwj_aiS8EXFcqtpogYKjPT82iIerwBsgHGCpdL0EsWMr338CRVw0FEeO8kapS839NbNpwCwhIQIC0AFZgXzvxV-5c-84XoQAKIv6IBDCNHPuYZrXWvARRmlDLI8H", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    let parameters = ["path": "/O/S"]
    let body = try! JSONEncoder().encode(parameters)
    request.httpBody = body
//    print(String(decoding: request.httpBody!, as: UTF8.self))
    let task = session.dataTask(with: request) { data, response, error in
        print("hmmm")
        if let error = error {
            print("Error ", error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("Not a good response")
            return
        }
        
        if !(200 ... 299).contains(response.statusCode) {
            print("Status not Ok")
            print(response.statusCode)
            return
        }
        
        guard let data = data else {
            print("No data returned")
            return
        }
        do {
            let result = try JSONSerialization.jsonObject(with: data)
            print(result)
        } catch {
            print(error)
        }
        
        
    }
    task.resume()
}

struct UploadParameters: Codable {
    
    let autorename: Bool
    let mode: String
    let mute: Bool
    let path: String
    let strictConflict: Bool
}

func upload() {
    let url = URL(string: "https://content.dropboxapi.com/2/files/upload")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    // Set the authorization header
    let accessToken = "sl.BVSCLFsEhyePzx7beMKqbNjuqMCcVrAdaAPiyWB_bH6-Kb-Vzh_x1x6Cz-GC3TTC4WbCATdLEu94cr8M_Na1vqcSwTajS8nSxn_bHSOCJ2GS9LieT9Tx0dakHrLU-BJNOv7r0Xdixtds"
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

//     Set the Dropbox-API-Arg header
    let apiArg = "{\"autorename\":false,\"mode\":\"add\",\"mute\":false,\"path\":\"/Homework/math/kk.png\",\"strict_conflict\":false}"
    request.setValue(apiArg, forHTTPHeaderField: "Dropbox-API-Arg")
    

    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    let body = UploadParameters(autorename: false, mode: "add", mute: false, path: "/Homework/math/ad.png", strictConflict: false)
    request.httpBody = try! JSONEncoder().encode(body)
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent("d.png")

    print(documentsDirectory)
    do {
        let fileData = try Data(contentsOf: fileURL)
    
        var session = URLSession.shared
        let task = session.uploadTask(with: request, from: fileData){ data, response, error in
            
            if let error = error {
                print("Error ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Not a good response")
                return
            }
            
            if !(200 ... 299).contains(response.statusCode) {
                print("Status not Okkk")
                print(response.statusCode)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data)
                print(result)
            } catch {
                print(error)
            }
            
            
        }
        task.resume()
    } catch {
        print(error)
    }
    
//    print(String(decoding: request.httpBody!, as: UTF8.self))
    
}

func downlaodImage() {
    let imageUrlString = "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
    
    guard let imageUrl = URL(string: imageUrlString) else {
        print("Not a valid URL")
        return
    }
    
    var urlRequest = URLRequest(url: imageUrl)
    
    //        urlRequest.allHTTPHeaderFields = headers
    
    let session = URLSession.shared
    
    let task = session.downloadTask(with: urlRequest) { data, response, error in
        
        if let error = error {
            print("Error ", error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("Not a good response")
            return
        }
        
        guard (200 ... 299).contains(response.statusCode) else {
            print("Status not Ok")
            return
        }
        
        guard let data = data else {
            print("Bad Data")
            return
        }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileURL = documentsDirectory.appendingPathComponent("d.png")
                do {
                    let img = try Data(contentsOf: data)
                    try img.write(to: fileURL)
                    print(fileURL)
                } catch {
                    print("can't Save \(error)")
                }
    }
    task.resume()
}


upload()


