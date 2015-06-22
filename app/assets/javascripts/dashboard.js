// Morris Area Chart
$(document).ready(function() { 

  new Morris.Area({
	  // ID of the element in which to draw the chart.
	  element: 'hero-area',
	  // Chart data records -- each entry in this array corresponds to a point on
	  // the chart.
	  data: [
	    { year: '2015-05-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-06-01', Cuota: 10022.16, Mora: 10022.16 },
	    { year: '2015-07-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-08-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-09-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-10-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-11-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2015-12-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2016-01-01', Cuota: 10022.16, Mora: 10522.16 },
	    { year: '2016-02-01', Cuota: 10022.16, Mora: 10522.16 }

	  ],
	  xkey: 'year',
	  ykeys: ['Cuota', 'Mora'],
	  // Labels for the ykeys -- will be displayed when you hover over the
	  // chart.
	  labels: ['Cuota'],
    lineColors: ["#81d5d9", "#a6e182"]

	});;

});
