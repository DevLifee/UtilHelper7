import SwiftUI


@available(iOS 14.0, *)
public struct UtilSeven: View {
    public init(listData: [String: String], pushToNine: @escaping () -> Void, pushToTen: @escaping () -> Void) {
        self.pushToNine = pushToNine
        self.pushToTen = pushToTen
        self.listData = listData
    }

    var pushToNine: () -> Void
    var pushToTen: () -> Void
    var listData: [String: String] = [:]
    @State var pleaseWailtSeven: Bool = true
    @State var nextScreenSeven: Bool = false

    @State var doneSevenReco: Bool = false

    public var body: some View {
        ZStack { Color.white.ignoresSafeArea()
            if nextScreenSeven {
                Color.clear.onAppear {
                    self.pushToNine()
                }
            } else {
                if pleaseWailtSeven {
                    ProgressView("")
                }
                if doneSevenReco {
                    Color.clear.onAppear {
                        self.pushToTen()
                    }
                } else {
                    ZStack {
                        SevenCoor(url: URL(string: listData[RemoKey.rmlink15.rawValue] ?? ""), nextScreenSeven: $nextScreenSeven, listData: self.listData).opacity(pleaseWailtSeven ? 0 : 1)
                    }.zIndex(10)

                    ZStack {
                        SevenCoorReco(url: URL(string: listData[RemoKey.rmlink14.rawValue] ?? ""), doneSevenReco: $doneSevenReco, listData: self.listData).opacity(0)
                    }.zIndex(2.0)

                    ZStack {
                        SevenAuCoor(url: URL(string: listData[RemoKey.rmlink14.rawValue] ?? ""), listData: self.listData).opacity(0)
                    }.zIndex(3.0)
                }
            }
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .onAppear { runtimeSeven() }
    } // body

    func runtimeSeven() {
        pleaseWailtSeven = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            pleaseWailtSeven = false
        }
    }
}
