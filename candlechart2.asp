
<html>
  <head>
    <title>Candlestick Chart</title>
    <link type="text/css" rel="stylesheet" href="ex.css?3.2"/>
    <script type="text/javascript" src="../protovis-d3.2.js"></script>
    <script type="text/javascript" src="vix.js"></script>
    <style type="text/css">

#fig {
  width: 900px;
  height: 220px;
}

    </style>
  </head>
  <body><div id="center"><div id="fig">
    <script type="text/javascript+protovis">

        /* Parse dates. */
        var dateFormat = pv.Format.date("%d-%b-%y");
        vix.forEach(function(d) d.date = dateFormat.parse(d.date));

            /* Scales. */
            var w = 840,
                h = 200,
                x = pv.Scale.linear(vix, function(d) d.date).range(0, w),
                y = pv.Scale.linear(vix, function(d) d.low, function(d) d.high).range(0, h).nice();

                    var vis = new pv.Panel()
                        .width(w)
                        .height(h)
                        .margin(10)
                        .left(30);

                    /* Dates. */
                    vis.add(pv.Rule)
                         .data(x.ticks())
                         .left(x)
                         .strokeStyle("#eee")
                       .anchor("bottom").add(pv.Label)
                         .text(x.tickFormat);

                    /* Prices. */
                    vis.add(pv.Rule)
                         .data(y.ticks(7))
                         .bottom(y)
                         .left(-10)
                         .right(-10)
                         .strokeStyle(function(d) d % 10 ? "#ccc" : "#333")
                       .anchor("left").add(pv.Label)
                         .textStyle(function(d) d % 10 ? "#999" : "#333")
                         .text(y.tickFormat);

                             /* Candlestick. */
                             vis.add(pv.Rule)
                                 .data(vix)
                                 .left(function(d) x(d.date))
                                 .bottom(function(d) y(Math.min(d.high, d.low)))
                                 .height(function(d) Math.abs(y(d.high) - y(d.low)))
                                 .strokeStyle(function(d) d.open < d.close ? "#ae1325" : "#06982d")
                               .add(pv.Rule)
                                 .bottom(function(d) y(Math.min(d.open, d.close)))
                                 .height(function(d) Math.abs(y(d.open) - y(d.close)))
                                 .lineWidth(10);

                                     vis.render();



var vix = [
  { date: '01-Jun-2009', open: 28.7, high: 30.05, low: 28.45, close: 30.04, signal: 'short', ret: -4.89396411092985 },
  { date: '02-Jun-2009', open: 30.04, high: 30.13, low: 28.3, close: 29.63, signal: 'short', ret: -0.322580645161295 },
  { date: '03-Jun-2009', open: 29.62, high: 31.79, low: 29.62, close: 31.02, signal: 'short', ret: 3.68663594470045 },
  { date: '04-Jun-2009', open: 31.02, high: 31.02, low: 29.92, close: 30.18, signal: 'short', ret: 4.51010886469673 },
  { date: '05-Jun-2009', open: 29.39, high: 30.81, low: 28.85, close: 29.62, signal: 'short', ret: 6.08424336973478 },
  { date: '08-Jun-2009', open: 30.84, high: 31.82, low: 26.41, close: 29.77, signal: 'short', ret: 1.2539184952978 },
  { date: '09-Jun-2009', open: 29.77, high: 29.77, low: 27.79, close: 28.27, signal: 'short', ret: -5.02431118314424 },
  { date: '10-Jun-2009', open: 26.9, high: 29.74, low: 26.9, close: 28.46, signal: 'short', ret: -5.46623794212217 },
  { date: '11-Jun-2009', open: 27.36, high: 28.11, low: 26.81, close: 28.11, signal: 'short', ret: -8.3743842364532 },
  { date: '12-Jun-2009', open: 28.08, high: 28.5, low: 27.73, close: 28.15, signal: 'short', ret: -5.52763819095477 },
  { date: '15-Jun-2009', open: 29.7, high: 31.09, low: 29.64, close: 30.81, signal: 'long', ret: 3.4920634920635 },
  { date: '16-Jun-2009', open: 30.81, high: 32.75, low: 30.07, close: 32.68, signal: 'short', ret: 0.155038759689914 },
  { date: '17-Jun-2009', open: 31.19, high: 32.77, low: 30.64, close: 31.54, signal: 'short', ret: 5.82822085889571 },
  { date: '18-Jun-2009', open: 31.54, high: 31.54, low: 29.6, close: 30.03, signal: 'short', ret: 8.17610062893082 },
  { date: '19-Jun-2009', open: 29.16, high: 29.32, low: 27.56, close: 27.99, signal: 'short', ret: 8.59872611464968 },
  { date: '22-Jun-2009', open: 30.4, high: 32.05, low: 30.3, close: 31.17, signal: 'short', ret: 15.4907975460123 },
  { date: '23-Jun-2009', open: 31.3, high: 31.54, low: 27.83, close: 30.58, signal: 'short', ret: 11.7370892018779 },
  { date: '24-Jun-2009', open: 30.58, high: 30.58, low: 28.79, close: 29.05, signal: 'long', ret: -10.4234527687296 },
  { date: '25-Jun-2009', open: 29.45, high: 29.56, low: 26.3, close: 26.36, signal: 'long', ret: 0 },
  { date: '26-Jun-2009', open: 27.09, high: 27.22, low: 25.76, close: 25.93, signal: 'long', ret: 0 },
  { date: '29-Jun-2009', open: 25.93, high: 27.18, low: 25.29, close: 25.35, signal: 'long', ret: 5.26315789473684 },
  { date: '30-Jun-2009', open: 25.36, high: 27.38, low: 25.02, close: 26.35, signal: 'long', ret: 6.73758865248228 },
  { date: '01-Jul-2009', open: 25.73, high: 26.31, low: 24.8, close: 26.22, signal: 'long', ret: 7.83645655877341 },
  { date: '02-Jul-2009', open: 26.22, high: 28.62, low: 26.22, close: 27.95, signal: 'long', ret: 2.76422764227643 },
  { date: '06-Jul-2009', open: 30.32, high: 30.6, low: 28.99, close: 29, signal: 'short', ret: -2.14521452145214 },
  { date: '07-Jul-2009', open: 29, high: 30.94, low: 28.9, close: 30.85, signal: 'short', ret: 3.03514376996805 },
  { date: '08-Jul-2009', open: 30.85, high: 33.05, low: 30.43, close: 31.3, signal: 'short', ret: 5.68720379146919 },
  { date: '09-Jul-2009', open: 30.23, high: 30.49, low: 29.28, close: 29.78, signal: 'short', ret: 8.22784810126583 },
  { date: '10-Jul-2009', open: 29.78, high: 30.34, low: 28.82, close: 29.02, signal: 'short', ret: 8.64779874213836 },
  { date: '13-Jul-2009', open: 28.36, high: 29.24, low: 25.42, close: 26.31, signal: 'short', ret: 7.32899022801303 },
  { date: '14-Jul-2009', open: 26.31, high: 26.84, low: 24.99, close: 25.02, signal: 'short', ret: 7.30897009966778 },
  { date: '15-Jul-2009', open: 25.05, high: 26.06, low: 23.83, close: 25.89, signal: 'neutral', ret: 0 },
  { date: '16-Jul-2009', open: 25.96, high: 26.18, low: 24.51, close: 25.42, signal: 'long', ret: -9.82758620689656 },
  { date: '17-Jul-2009', open: 25.42, high: 25.55, low: 23.88, close: 24.34, signal: 'long', ret: -10.8433734939759 },
  { date: '20-Jul-2009', open: 25.06, high: 25.42, low: 24.26, close: 24.4, signal: 'long', ret: -7.55711775043936 },
  { date: '21-Jul-2009', open: 24.28, high: 25.14, low: 23.81, close: 23.87, signal: 'long', ret: -2.5089605734767 },
  { date: '22-Jul-2009', open: 24.05, high: 24.14, low: 23.24, close: 23.47, signal: 'long', ret: 0.915750915750916 },
  { date: '23-Jul-2009', open: 23.71, high: 24.05, low: 23.21, close: 23.43, signal: 'long', ret: 2.47148288973383 },
  { date: '24-Jul-2009', open: 23.87, high: 23.87, low: 23, close: 23.09, signal: 'long', ret: 4.22264875239922 },
  { date: '27-Jul-2009', open: 24.06, high: 24.86, low: 24.02, close: 24.28, signal: 'long', ret: -0.189393939393929 },
  { date: '28-Jul-2009', open: 24.28, high: 25.61, low: 24.28, close: 25.01, signal: 'long', ret: -4.37956204379562 },
  { date: '29-Jul-2009', open: 25.47, high: 26.18, low: 25.41, close: 25.61, signal: 'long', ret: -4.48504983388705 },
  { date: '30-Jul-2009', open: 25.4, high: 25.76, low: 24.85, close: 25.4, signal: 'long', ret: -1.70357751277683 },
  { date: '31-Jul-2009', open: 25.4, high: 26.22, low: 24.93, close: 25.92, signal: 'short', ret: 5.06756756756757 },
];