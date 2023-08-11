# NetworkWrapper
## A simple wrapper for URLSession

```
let dispatcher = Dispatcher(baseUrl: "https://sample_url.com")
let result = await dispatcher.execute(request: AnimalRequest.list, of: [Animal].self)
```

### Create Request

```
enum BaseRequest: Request {
    case path1
    case path2
    
    var path: String {
        switch self {
        case .path1:
            return "/path_1"
        case .path2:
            return "/path_2"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .path1:
            return .post
        case .path2:
            return .get
        }
    }
    
    var headers: ReaquestHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: RequestParameters? {
        nil
    }
}

```
### Create Model
```
struct Animal: Codable {
    var id: String
    var name: String
    var image: String
}
```
