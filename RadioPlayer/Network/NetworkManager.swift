import Foundation
import Combine

final class NetworkManager: ObservableObject {

    @Published var stations: [Station] = []

    func getStations(completion: @escaping () -> ()) {
        guard let url = URL(string: "http://at1.api.radio-browser.info/json/stations/bycountry/russia") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedStations = try JSONDecoder().decode([Station].self, from: data)
                        self.stations = decodedStations
                        completion()
                        print(decodedStations)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }

}


