$ ->
  riskColors =
    "very_high": "#F88770"
    "high": "#FAD669"
    "moderate": "#95D2BB"
    "low": "#52DBEF"
    "none": "#ffffff"

  transitionState = (state, risk) ->
    
    d3.selectAll(".state-#{state}")
      .transition()
      .style("fill", riskColors[risk])

  processData = (data) ->
    for state in data
      transitionState(state.id, state.risk)

  start = [
    { id: "TX", risk: "moderate" }
    { id: "CA", risk: "low" }
    { id: "PA", risk: "low" }
    { id: "NY", risk: "low" }
    { id: "AL", risk: "very_high" }    
  ]
  step1 = [
    { id: "TX", risk: "high" }
    { id: "CA", risk: "low" }
  ]
  step2 = [
    { id: "TX", risk: "very_high" }
    { id: "CA", risk: "moderate" }
  ]
  states = [
    "TX", "CA", "AK"         
  ]
  
  statesCircles = [
    {
      state: "TX"
      circles: [
        { x: 430, y: 450, r: 10 }
        { x: 440, y: 460, r: 5 }
        { x: 410, y: 460, r: 15 }        
      ]
    },
    {
      state: "CA" 
      circles: [
        { x: 130, y: 350, r: 10 }
        { x: 140, y: 360, r: 5 }
        { x: 110, y: 330, r: 15 }        
      ]      
    },
    {
      state: "AK" 
      circles: [
        { x: 140, y: 500, r: 10 }
        { x: 140, y: 512, r: 5 }
        { x: 120, y: 490, r: 15 }        
      ]      
    }    
  ]

  $("#usa-circles").each () ->
    
    svg = d3.select("#usamap")    
    
    for stateData in statesCircles
      console.log stateData
      svg.selectAll(".state-#{stateData.state}")
        .data(stateData.circles)    
        .enter()
        .append("svg:circle")
        .attr("r", (d) -> d.r)
        .attr("cx", (d) -> d.x)
        .attr("cy", (d) -> d.y)
        .attr("class", (d) -> "state-circle state-#{stateData.state}")
    
  $("#start").click () ->
    processData(start)

  $("#step-1").click () ->
    processData(step1)

  $("#step-2").click () ->
    processData(step2)

  $("#random-circles").click () ->
    for state in states
      random_risk_index = Math.floor(Math.random() * 4)
      risks = ["very_high", "high", "moderate", "low", "none"]
      risk = risks[random_risk_index]
      console.log risk
      console.log state
      transitionState(state, risk)
    
