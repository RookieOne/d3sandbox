$ ->
  collide = (node) ->
    r = node.radius + 16
    nx1 = node.x - r
    nx2 = node.x + r
    ny1 = node.y - r
    ny2 = node.y + r
    (quad, x1, y1, x2, y2) ->
      if quad.point and (quad.point isnt node)
        x = node.x - quad.point.x
        y = node.y - quad.point.y
        l = Math.sqrt(x * x + y * y)
        r = node.radius + quad.point.radius
        if l < r
          l = (l - r) / l * .5
          node.x -= x *= l
          node.y -= y *= l
          quad.point.x += x
          quad.point.y += y
      x1 > nx2 or x2 < nx1 or y1 > ny2 or y2 < ny1
      
  $("#bubble-basic").each () ->
    console.log "foo"

    data = {
      children: []
    }
    data.children.push
      "value": 1
      "name": "Foo"
    data.children.push
      "value": 3
      "name": "Bar"
      

    width = 960
    height = 960
    bubble = d3.layout.pack().size(width, height).padding(1.5)

    svg = d3.select("#chart")
      .append("svg")
      .attr("width", width)
      .attr("height", height)
      .attr("class", "bubble")

    # @data.forEach (d) =>
    #       node = {
    #         id: d.id
    #         radius: @radius_scale(parseInt(d.total_amount))
    #         value: d.total_amount
    #         name: d.grant_title
    #         org: d.organization
    #         group: d.group
    #         year: d.start_year
    #         x: Math.random() * 900
    #         y: Math.random() * 800
    #       }
    #       @nodes.push node

    # bubbles = svg.selectAll("bubble")
    # .data(data, (d) -> d.id)
    # console.log data
    bubbles = d3.range(200).map(() -> { radius: Math.random() * 12 + 4 })
    # d = { children: data }
    # console.log d
    # bubbles = bubble.nodes(data)
    # console.log bubbles
    # bubbles.enter().append("circle")
    # .attr("r", (d) -> d.radius)
    # .attr("transform", (d) -> "translate(#{d.x}, #{d.y})")

    force = d3.layout.force()
        .gravity(0.05)
        .charge((d, i) -> i ? 0 : -2000)
        .nodes(bubbles)
        .size([width, height]);

    force.start()

    svg.selectAll("circle")
      .data(bubbles).enter()
      .append("svg:circle")
      .attr("r", (d) -> d.radius)

    force.on "tick", (e) ->
      q = d3.geom.quadtree(bubbles)
      i = 0
      n = bubbles.length

      while (++i < n)
        q.visit(collide(bubbles[i]))

      svg.selectAll("circle")
          .attr("cx", (d) -> d.x )
          .attr("cy", (d) -> d.y )
