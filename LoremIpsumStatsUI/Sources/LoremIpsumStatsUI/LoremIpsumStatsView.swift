import SwiftUI

import LoremIpsum

/// Here we demonstrate how often words of each length occur in the database
class StatsModel {
    
    struct Stat: Identifiable, Hashable {
        var id: Int { numberOfLetters }
        var numberOfLetters: Int
        var numberOfOccurances: Int
        var barSize: CGSize?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    var lipsum = String.LoremIpsum()
    
    var longestLength: Int {
        lipsum.longestWordLength
    }
    
    var largestNumber: Int {
        stats.map(\.numberOfOccurances).max() ?? 0
    }
    
    lazy var stats: [Stat] = {
        let dist = lipsum.wordsLengthDistribution()
        return (1...longestLength).map { l in
            Stat(numberOfLetters: l, numberOfOccurances: dist[l] ?? 0)
        }
        .sorted(using: KeyPathComparator(\.numberOfLetters))
    }()
    
    func barSize(for geometry: GeometryProxy, stat: Stat) -> CGSize {
        let w = (geometry.size.width - CGFloat(stats.count * 3)) / CGFloat(stats.count)
        let h = (geometry.size.height - 50) *  CGFloat(stat.numberOfOccurances) /  CGFloat(largestNumber)
        return CGSize(width: w, height: h == 0 ? 1 : h)
    }
    
    func stats(for geometry: GeometryProxy) -> [Stat] {
        let x = stats.map { stat in
            var new = stat
            new.barSize = barSize(for: geometry, stat: stat)
            return new
        }
        return x
    }
}


struct StatWindow: View {
    var stat: StatsModel.Stat
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button("", systemImage: "x.square") {
                dismiss()
            }
            .offset(x: 30, y: -10)
            Text("# of letters: \(stat.numberOfLetters)")
            Text("# of occurances: \(stat.numberOfOccurances)")
        }
        .padding()
        .background(
            Rectangle()
                .stroke(lineWidth: 2)
                .overlay(
                    Rectangle()
                        .fill(Material.thin)
                )
        )
    }
}

struct SwiftUIView: View {
    var model = StatsModel()
    
    @State var textScale = 1.0
    
    @State var statBeingShowedAsPopup: StatsModel.Stat?
    @State var popupLocation: CGPoint?
    
    struct TextScalePreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 1.0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = min(value, nextValue())
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(String.Lorem(generate: .sentence(num: 1, startsWithFirstSentence: false)))
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            GeometryReader { geo in
                Grid(horizontalSpacing: 3) {
                    GridRow {
                        ForEach(model.stats(for: geo)) { stat in
                            Text("\(statBeingShowedAsPopup == stat ? "# letters: \(stat.numberOfLetters)" : "")\(stat.numberOfOccurances)")
                                .font(.largeTitle)
                                .lineLimit(1)
                                .frame(height: 25)
                                .minimumScaleFactor(0.2)
                                .scaleEffect(statBeingShowedAsPopup == stat ? 4.5 : 1.0)
                                .animation(.easeInOut(duration: 1), value: statBeingShowedAsPopup)
                        }
                    }
                    GridRow(alignment: .bottom) {
                        ForEach(model.stats(for: geo)) { stat in
                            Rectangle()
                                .fill(Color.blue)
                            
                                .frame(width: stat.barSize?.width, height: stat.barSize?.height)
                                .gesture(SpatialTapGesture(coordinateSpace: .global)
                                    .onEnded { val in
//                                        statBeingShowedAsPopup = stat
                                        popupLocation =  val.location
                                    }
                                )
                        }
                    }
                    
                    GridRow {
                        ForEach(model.stats(for: geo)) { stat in
                            Text("\(stat.numberOfLetters)")
                                .font(.caption2)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                                .frame(height: 25)
                        }
                    }
                }
            }
        }

        .padding(20)
    }
    
    struct PopupWindowSizingPreferenceKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            //            value = max(value, nextValue())
            let origin = CGPoint(x: min(value.origin.x, nextValue().origin.x),
                                 y: min(value.origin.y, nextValue().origin.y))
            let size =
            CGSize(width: max(value.width, nextValue().width),
                   
                   height: max(value.height, nextValue().height))
            
            value = CGRect(origin: origin, size: size)
        }
    }
}

#Preview {
    SwiftUIView()
}
