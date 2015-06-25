// Morris Area Chart
$(document).ready(function() { 

  new Morris.Area({
	  // ID of the element in which to draw the chart.
	  element: 'hero-area',
	  // Chart data records -- each entry in this array corresponds to a point on
	  // the chart.
	  data: [
	    { year: '2015-05-01', Balance: 500000, Pago: 10522.16 },
	    { year: '2015-06-01', Balance: 450000, Pago: 10022.16 },
	    { year: '2015-07-01', Balance: 400000, Pago: 0 },
	    { year: '2015-08-01', Balance: 350000, Pago: 12000 },
	    { year: '2015-09-01', Balance: 300000, Pago: 0 },
	    { year: '2015-10-01', Balance: 280000, Pago: 0 },
	    { year: '2015-11-01', Balance: 200000, Pago: 0 },
	    { year: '2015-12-01', Balance: 150000, Pago: 0 },
	    { year: '2016-01-01', Balance: 100000, Pago: 0 },
	    { year: '2016-02-01', Balance: 50000, Pago:  0},
	    { year: '2016-02-01', Balance: 0, Pago: 0 }

	  ],
	  xkey: 'year',
	  ykeys: ['Balance', 'Pago'],
	  // Labels for the ykeys -- will be displayed when you hover over the
	  // chart.
	  labels: ['Balance'],
    lineColors: ["#81d5d9", "#a6e182"]

	});;




});
