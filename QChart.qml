/* QChart.qml ---
 *
 * Author: Julien Wintz
 * Created: Thu Feb 13 20:59:40 2014 (+0100)
 * Version:
 * Last-Updated: jeu. mars  6 12:55:14 2014 (+0100)
 *           By: Julien Wintz
 *     Update #: 69
 */

/* Change Log:
 *
 */

import QtQuick 2.0

import "QChart.js" as Charts

Canvas {

  id: canvas;

// ///////////////////////////////////////////////////////////////

  property   var chart;
  property   var chartData;
  property   int chartType: 0;
  property  bool chartAnimated: true;
  property alias chartAnimationEasing: chartAnimator.easing.type;
  property alias chartAnimationDuration: chartAnimator.duration;
  property   int chartAnimationProgress: 0;
  property   var chartOptions: ({})

// /////////////////////////////////////////////////////////////////
// Callbacks
// /////////////////////////////////////////////////////////////////
  MouseArea {
        id:mousearea
        anchors.fill: parent
        cursorShape:Qt.PointingHandCursor
        onPositionChanged: canvas.requestPaint();

        onPressed: {

            //          var mousePosition = mouse.x / mousearea.width;

//            console.log("onPressed : Mouse position  " + mouse.x +":"+mouse.y)
            checkinside(mouse.x, mouse.y)

        }
        function checkinside(x, y){

            for (var j=0; j<chartData.length; j++){
                for (var i=0; i<chartData[j].length; i++) {
                    //                   console.log("in loop ")
                    isPieInside(x , y , chartData[j][i])
                    //                      chartData[j][i].isSelected = true ;
                }
            }
            requestPaint();
        }
        function isPieInside( xglobal, yglobal , pie){
            //          console.log("AD") ;
            var x = xglobal-pie.xcenter;
            var y = yglobal-pie.ycenter;
            var raduis = Math.sqrt((x*x)+(y*y));
            var angle ;

            angle  = Math.atan2(x,y)*180/Math.PI;
            angle = (270+angle)  %360  ;
            angle = 360 -angle;
//            console.log("AD =>"+raduis  ) ;
//            console.log("AD =>rayonMin"+pie.rayonMin  ) ;
//            console.log("AD =>rayonMax"+pie.rayonMax  ) ;

            if(angle>pie.angleStart && angle<(pie.angleStart+pie.anglesegement)
                    && raduis>pie.rayonMin && raduis<pie.rayonMax){
//                console.log("TTTTTTTT");
//                console.log("AD =>angleStart "+pie.angleStart  ) ;
//                console.log("AD =>anglesegement"+pie.anglesegement  ) ;
//                console.log("AD =>"+raduis  ) ;
//                console.log("AD =>"+angle) ;
                pie.isSelected=!pie.isSelected;
                requestPaint();
            }


        }
        onReleased: {
            var mousePosition = mouse.x / mousearea.width;
            //console.log("onReleased :Mouse position  " + mouse.x +":"+mouse.y)

        }
    }
    Rectangle{
    id : controle
     anchors.top : parent
     anchors.left : parent.left
     anchors.right : parent.right
     height:  5
     Flow{
         Button{
             z : 100
             text : "Select ALL"
             onClicked: selectclear(true);
         }
         Button{
              text : "clear all ALL"
               onClicked: selectclear(false);
         }
         Button{
              text : "no action"
         }
     }

    }
 
  onPaint: {
      var ctx = canvas.getContext("2d");
      /* Reset the canvas context to allow resize events to properly redraw
         the surface with an updated window size */
      ctx.reset()
    var concretChart =new Charts.Chart(canvas, ctx) ;
      switch(chartType) {
      case Charts.ChartType.BAR:
          chart = new concretChart.Bar(chartData, chartOptions);
          break;
      case Charts.ChartType.DOUGHNUT:
          chart = new concretChart.Doughnut(chartData, chartOptions);
          break;
      case Charts.ChartType.LINE:
          chart = new concretChart.Line(chartData, chartOptions);
          break;
      case Charts.ChartType.PIE:
          chart = new concretChart.Pie(chartData, chartOptions);
          break;
      case Charts.ChartType.POLAR:
          chart = new concretChart.PolarArea(chartData, chartOptions);
          break;
      case Charts.ChartType.RADAR:
          chart = new concretChart.Radar(chartData, chartOptions);
          break;
      default:
          console.log('Chart type should be specified.');
      }

      chart.init();

      if (chartAnimated)
          chartAnimator.start();
      else
          chartAnimationProgress = 100;

      chart.draw(chartAnimationProgress/100);
  }

  onHeightChanged: {
    requestPaint();
  }

  onWidthChanged: {
    requestPaint();
  }

  onChartAnimationProgressChanged: {
      requestPaint();
  }

// /////////////////////////////////////////////////////////////////
// Functions
// /////////////////////////////////////////////////////////////////

  function repaint() {
      chartAnimationProgress = 0;
      chartAnimator.start();
  }

// /////////////////////////////////////////////////////////////////
// Internals
// /////////////////////////////////////////////////////////////////

  PropertyAnimation {
             id: chartAnimator;
         target: canvas;
       property: "chartAnimationProgress";
             to: 100;
       duration: 500;
    easing.type: Easing.InOutElastic;
  }
}
