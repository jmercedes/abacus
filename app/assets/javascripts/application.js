// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function () {

    // jQuery Knobs
    $(".knob").knob();



    // jQuery UI Sliders
    $(".slider-sample1").slider({
        value: 100,
        min: 1,
        max: 500
    });
    $(".slider-sample2").slider({
        range: "min",
        value: 130,
        min: 1,
        max: 500
    });
    $(".slider-sample3").slider({
        range: true,
        min: 0,
        max: 500,
        values: [ 40, 170 ],
    });

    

    // jQuery Flot Chart
    var visits = [[1, 50], [2, 40], [3, 45], [4, 23],[5, 55],[6, 65],[7, 61],[8, 70],[9, 65],[10, 75],[11, 57],[12, 59]];
    var visitors = [[1, 25], [2, 50], [3, 23], [4, 48],[5, 38],[6, 40],[7, 47],[8, 55],[9, 43],[10,50],[11,47],[12, 39]];

    var plot = $.plot($("#statsChart"),
        [ { data: visits, label: "Signups"},
         { data: visitors, label: "Visits" }], {
            series: {
                lines: { show: true,
                        lineWidth: 1,
                        fill: true, 
                        fillColor: { colors: [ { opacity: 0.1 }, { opacity: 0.13 } ] }
                     },
                points: { show: true, 
                         lineWidth: 2,
                         radius: 3
                     },
                shadowSize: 0,
                stack: true
            },
            grid: { hoverable: true, 
                   clickable: true, 
                   tickColor: "#f9f9f9",
                   borderWidth: 0
                },
            legend: {
                    // show: false
                    labelBoxBorderColor: "#fff"
                },  
            colors: ["#a7b5c5", "#30a0eb"],
            xaxis: {
                ticks: [[1, "JAN"], [2, "FEB"], [3, "MAR"], [4,"APR"], [5,"MAY"], [6,"JUN"], 
                       [7,"JUL"], [8,"AUG"], [9,"SEP"], [10,"OCT"], [11,"NOV"], [12,"DEC"]],
                font: {
                    size: 12,
                    family: "Open Sans, Arial",
                    variant: "small-caps",
                    color: "#697695"
                }
            },
            yaxis: {
                ticks:3, 
                tickDecimals: 0,
                font: {size:12, color: "#9da3a9"}
            }
         });

    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            top: y - 30,
            left: x - 50,
            color: "#fff",
            padding: '2px 5px',
            'border-radius': '6px',
            'background-color': '#000',
            opacity: 0.80
        }).appendTo("body").fadeIn(200);
    }

    var previousPoint = null;
    $("#statsChart").bind("plothover", function (event, pos, item) {
        if (item) {
            if (previousPoint != item.dataIndex) {
                previousPoint = item.dataIndex;

                $("#tooltip").remove();
                var x = item.datapoint[0].toFixed(0),
                    y = item.datapoint[1].toFixed(0);

                var month = item.series.xaxis.ticks[item.dataIndex].label;

                showTooltip(item.pageX, item.pageY,
                            item.series.label + " of " + month + ": " + y);
            }
        }
        else {
            $("#tooltip").remove();
            previousPoint = null;
        }
    });
});
