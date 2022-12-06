//
//  MyPorsche.swift
//  MyPorsche
//
//  Created by Alpay Kücük on 18.10.22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let defaults = UserDefaults(suiteName: "group.myporsche")
        let savedUrl = defaults!.string(forKey: "selectedWidget") ?? "https://picserv.porsche.com/picserv/images-api/v1/734001fa9334d92a842dfb63fee20221/2"
       
        return SimpleEntry(date: Date(), selectedWidgetUrl: savedUrl)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let defaults = UserDefaults(suiteName: "group.myporsche")
        let savedUrl = defaults!.string(forKey: "selectedWidget") ?? "https://picserv.porsche.com/picserv/images-api/v1/734001fa9334d92a842dfb63fee20221/2"
        let entry = SimpleEntry(date: Date(), selectedWidgetUrl: savedUrl)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let currentDate = Date()
        let defaults = UserDefaults(suiteName: "group.myporsche")
        let savedUrl = defaults!.string(forKey: "selectedWidget") ?? "https://picserv.porsche.com/picserv/images-api/v1/734001fa9334d92a842dfb63fee20221/2"
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: Date(), selectedWidgetUrl: savedUrl)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let selectedWidgetUrl: String
}

struct MyPorscheEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    @Environment(\.colorScheme) var colorScheme
    var entry: Provider.Entry
    var body: some View {
        switch family {
        case .systemSmall:
            ZStack {
                VStack {
                    NetworkImage(url: URL(string: entry.selectedWidgetUrl))
                    Text("Hallo")
                }
            }
        case .systemMedium:
            ZStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 5){
                            Text("Porsche 718 Boxster GTS").font(Font.custom("helvetica", size: 15).bold())
                            Text("02938479237").font(Font.custom("helvetica", size: 12)).foregroundColor(colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3))
                            Image(systemName: "battery.50")
                            .foregroundColor(Color.green.opacity(1))
                            .buttonStyle(.borderedProminent)
                            .tint(Color.black.opacity(0.0))
                        }
                        
                        NetworkImage(url: URL(string: entry.selectedWidgetUrl))
                    }.padding(.top, 5)
                    
                    HStack {
                        Button {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        label: {
                        Image(systemName: "lock.fill")
                        }
                        .padding(10)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black.opacity(0.0))
                        Divider().frame(height: 20)
                        Button {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        label: {
                        Image(systemName: "fanblades.fill")
                        }
                        .padding(10)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black.opacity(0.0))
                        Divider().frame(height: 20)
                        Button {
                            
                        }
                        label: {
                        Image(systemName: "bolt.fill")
                        }
                        .padding(10)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black.opacity(0.0))
                        Divider().frame(height: 20)
                        Button {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        }
                        label: {
                        Image(systemName: "pencil")
                        }
                        .padding(10)
                        .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))
                        .buttonStyle(.borderedProminent)
                        .tint(Color.black.opacity(0.0))
                    }
                    
                    .background(colorScheme == .dark ? Color.white.opacity(0.0) : Color.black.opacity(0.02))
                    .cornerRadius(50)
                    .padding(.bottom, 5)
                }
            }
        case .systemLarge:
            ZStack {
                VStack {
                    Text("Hallo")
                    NetworkImage(url: URL(string: entry.selectedWidgetUrl))
                }

            }
        default:
            ZStack {
                VStack {
                    Text("Hallo")
                    NetworkImage(url: URL(string: entry.selectedWidgetUrl))
                }
            }
        }
    }
    
}

struct NetworkImage: View {

  public let url: URL?

  var body: some View {

    Group {
     if let url = url, let imageData = try? Data(contentsOf: url),
       let uiImage = UIImage(data: imageData) {

       Image(uiImage: uiImage)
         .resizable()
         .aspectRatio(contentMode: .fit)
      }
      else {
       Image(systemName: "boxster_gts")
      }
    }
  }

}

@main
struct MyPorsche: Widget {
    let kind: String = "MyPorsche"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            MyPorscheEntryView(entry: entry)
        }
        .configurationDisplayName("My Porsche")
        .description("This is the official My Porsche Widget!")
    }
}

struct MyPorsche_Previews: PreviewProvider {
    static var previews: some View {
        let defaults = UserDefaults(suiteName: "group.myporsche")
        let savedUrl = defaults!.string(forKey: "selectedWidget") ?? "https://picserv.porsche.com/picserv/images-api/v1/734001fa9334d92a842dfb63fee20221/2"
        MyPorscheEntryView(entry: SimpleEntry(date: Date(), selectedWidgetUrl: savedUrl))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
