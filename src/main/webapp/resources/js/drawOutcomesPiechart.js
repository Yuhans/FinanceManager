function drawChart(data) {
    // Define the chart to be drawn.
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Type');
    dataTable.addColumn('number', 'Amount');
    for (var key in data) {
        dataTable.addRow([key, data[key]]);
    }
    // Set chart options
    var options = {
        'title': 'Statistics',
        'width': 550,
        'height': 400
    };

    // Instantiate and draw the chart.
    var chart = new google.visualization.PieChart(document.getElementById('piechart'));
    chart.draw(dataTable, options);
}
google.charts.setOnLoadCallback(drawChart);