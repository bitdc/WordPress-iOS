import SwiftUI

struct TodayWidgetSmallView: View {
    let content: HomeWidgetData
    let widgetTitle: LocalizedStringKey
    let viewsTitle: LocalizedStringKey

    private var views: Int {
        (content as? HomeWidgetTodayData)?.stats.views ?? (content as? HomeWidgetAllTimeData)?.stats.views ?? 0
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                FlexibleCard(axis: .vertical, title: widgetTitle, value: .description(content.siteName))

                Spacer()
                VerticalCard(title: viewsTitle, value: views, largeText: true)
            }
            Spacer()
        }
        .flipsForRightToLeftLayoutDirection(true)
    }
}
