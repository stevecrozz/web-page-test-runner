google.load('visualization', '1', {'packages':['annotatedtimeline']});
google.setOnLoadCallback(startWpt);

function startWpt() {
  var root = $('#root');
  var chartDiv = $('<div>', { id: 'chart' });
  chartDiv.css({
    height: 500,
    width: 800
  });

  var appSelect, typeSelect, seriesSelect;

  var makeSelect = function(label, list, multiple) {
    var select;

    if (multiple) {
      select = $('<select name="app" multiple>');
    } else {
      select = $('<select name="app">');
    }

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
      draw(r);
    });
  };

  var draw = function(r){
    var data = new google.visualization.DataTable();
    data.addColumn('date', 'date');

    var columns = [];
    $.each(Object.getOwnPropertyNames(r[0]), function(_, name){
      if (name == 'date') { return; }
      columns.push(name);
      data.addColumn('number', name);
    });

    var rows = [];
    $.each(r, function(_, o){
      var row = [ new Date(o.date * 1000) ];

      $.each(columns, function(_, column){
        row.push(o[column]);
      });

      rows.push(row);
    });

    data.addRows(rows);

    var chart = new google.visualization.AnnotatedTimeLine(chartDiv.get(0));
    chart.draw(data, {displayAnnotations: true});
  };

  $.get('/filters.json', function(r){
    appSelect = makeSelect('app', r.name);
    typeSelect = makeSelect('type', r.type);
    seriesSelect = makeSelect('series', r.series, true);

    root.append(appSelect);
    root.append(typeSelect);
    root.append(seriesSelect);
    debugger
    root.append(chartDiv);
    chartIt();
  });

  root.on('change', 'select', chartIt);
}
