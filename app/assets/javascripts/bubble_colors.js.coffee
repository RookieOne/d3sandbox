$ ->

  $("#bubble-colors").each () ->
    console.log "aight"

    width = 960
    height = 960
    
    svg = d3.select("#chart")
      .append("svg")
      .attr("width", width)
      .attr("height", height)
    
    data = [
      { id: 1, class: "bubble-red", value: 30, x: 110, y: 80 }
      { id: 2, class: "bubble-yellow", value: 20, x: 150, y: 40 }
      { id: 3, class: "bubble-blue", value: 10, x: 200, y: 90 }
    ]

    svg.selectAll(".bubble")
      .data(data)
      .enter()
      .append("svg:circle")
      .attr("r", (d) -> d.value)
      .attr("class", (d) -> "bubble #{d.class}")
      .attr("cx", (d) -> d.x)
      .attr("cy", (d) -> d.y)

    $("#color-change1").click () ->
      console.log "click"
      svg.selectAll(".bubble")
        .transition()
        .duration(1000)
        .style("fill", "#333334")