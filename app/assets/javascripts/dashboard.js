// Morris Area Chart
$(document).ready(function() { 

Morris.Area({
    element: 'hero-area',
    behaveLikeLine: true,
    data: [
        {period: '2010 Q1', iphone: 2666, ipad: null},
        {period: '2010 Q2', iphone: 2778, ipad: 2294},
        {period: '2010 Q3', iphone: 4912, ipad: 1969},
        {period: '2010 Q4', iphone: 3767, ipad: 3597},
        {period: '2011 Q1', iphone: 6810, ipad: 1914},
        {period: '2011 Q2', iphone: 5670, ipad: 4293},
        {period: '2011 Q3', iphone: 4820, ipad: 3795},
        {period: '2011 Q4', iphone: 15073, ipad: 5967},
        {period: '2012 Q1', iphone: 10687, ipad: 4460},
        {period: '2012 Q2', iphone: 8432, ipad: 5713}
    ],
    xkey: 'period',
    ykeys: ['iphone', 'ipad'],
    labels: ['Pagos en fecha', 'Pagos Atrasado'],
    lineWidth: 2,
    hideHover: 'auto',
    lineColors: ["#81d5d9", "#a6e182"]
  });

});