google.load('visualization', '1', {'packages':['annotatedtimeline']});
google.setOnLoadCallback(startWpt);

function startWpt() {
  var root = $('#root');
  var chartDiv = $('<div', { id: 'chart' });

  var appSelect, typeSelect, seriesSelect;

  var makeSelect = function(label, list) {
    var select = $('<select name="app">');
    $.each(list, function(_, i){
      select.append($('<option>', { value: i, text: i }));
    });
    return select;
  }

  var chartIt = function(){
    var app = appSelect.val();
    var type = typeSelect.val();
    var series = seriesSelect.val();

    $.get('/series.json', {
      "app": app,
      "type": type,
      "series": series
    }, function(r){
      draw(data);
    });
  };

  var draw = function(data){
    var data = new google.visualization.DataTable();
      debugger
    data.addColumn('date', 'Date');
    data.addColumn('
    data.addRows([
      [new Date(2008, 1 ,1), 30000, undefined, undefined, 40645, undefined, undefined],
      [new Date(2008, 1 ,2), 14045, undefined, undefined, 20374, undefined, undefined],
      [new Date(2008, 1 ,3), 55022, undefined, undefined, 50766, undefined, undefined],
      [new Date(2008, 1 ,4), 75284, undefined, undefined, 14334, 'Out of Stock','Ran out of stock on pens at 4pm'],
      [new Date(2008, 1 ,5), 41476, 'Bought Pens','Bought 200k pens', 66467, undefined, undefined],
      [new Date(2008, 1 ,6), 33322, undefined, undefined, 39463, undefined, undefined]
    ]);

    var chart = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div'));
    chart.draw(data, {displayAnnotations: true});
  };

  $.get('/filters.json', function(r){
    appSelect = makeSelect('app', r.name);
    typeSelect = makeSelect('type', r.type);
    seriesSelect = makeSelect('series', r.series);

    root.append(appSelect);
    root.append(typeSelect);
    root.append(seriesSelect);
    chartIt();
  });

  root.on('change', 'select', chartIt);
}
