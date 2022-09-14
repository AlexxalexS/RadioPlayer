import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {

    @EnvironmentObject var network: NetworkManager
    @State var player: AVPlayer?
    @State var activeStation: Station = Station.defaultValue()
    @State var stations: [Station] = []

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    Text(activeStation.name ?? "")
                        .font(.title)
                        .frame(alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    HStack {
                        Spacer()

                        Button(action: {
                            loadRadio()
                        }) {
                            Image(systemName: "play.circle.fill").resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        }
                        Spacer()
                        Button(action: {
                            player?.pause()
                        }) {
                            Image(systemName: "pause.circle.fill").resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                        }
                        Spacer()
                        Button {
                            player?.pause()
                            activeStation = network.stations[Int.random(in: 1 ..< network.stations.count)]
                            loadRadio()
                        } label: {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                                .resizable()
                                .frame(maxWidth: 50, maxHeight: 50)
                                .aspectRatio(contentMode: .fill)
                        }
                        Spacer()
                    }
                    LazyVStack(alignment: .leading, spacing: 2) {
                        ForEach(stations, id: \.stationuuid) { station in
                            Button {
                                player?.pause()
                                activeStation = station
                                loadRadio()
                            } label: {
                                VStack(alignment: .leading) {
                                    HStack() {
                                        if let url = URL(string: station.favicon ?? "") {
                                            AsyncImage(url: url) { phases in
                                                switch phases {
                                                case .success(let image):
                                                    image.resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(maxWidth: 100)

                                                default:
                                                    Image(systemName: "xmark.octagon")
                                                }
                                            }
                                        }

                                        Text(station.name ?? "")
                                            .tint(.black)

                                        Spacer()

                                    }.padding()

                                    Divider()
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Сейчас играет")
        }.onAppear {
            network.getStations {
                stations = network.stations
                activeStation = network.stations[Int.random(in: 1 ..< network.stations.count)]
                loadRadio()
            }
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) { searchText in
                if !searchText.isEmpty {
                    stations = stations.filter {
                        $0.name?.contains(searchText) ?? false
                    }
                } else {
                    stations = network.stations
                }
            }

    }

    func filtering() {

    }

    func loadRadio() {
        guard let url = URL.init(string: activeStation.url ?? "") else { return }
        let playerItem = AVPlayerItem.init(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NetworkManager())
    }
}
