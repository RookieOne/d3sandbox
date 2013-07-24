$ ->
  riskColors =
    "very_high": "#F88770"
    "high": "#FAD669"
    "moderate": "#95D2BB"
    "low": "#52DBEF"
    "none": "#ffffff"

  transitionState = (state, risk) ->
    d3.select("##{state}").transition()
      .style("fill", riskColors[risk])

  processData = (data) ->
    for state in data
      transitionState(state.id, state.risk)

  start = [
    { id: "TX", risk: "moderate" }
    { id: "CA", risk: "low" }
    { id: "PA", risk: "low" }
    { id: "NY", risk: "low" }
  ]
  step1 = [
    { id: "TX", risk: "high" }
    { id: "CA", risk: "low" }
  ]
  step2 = [
    { id: "TX", risk: "very_high" }
    { id: "CA", risk: "moderate" }
  ]

  $("#usa-colors").each () ->

    console.log "usa"
    processData(start)
  $("#start").click () ->
    processData(start)

  $("#step-1").click () ->
    processData(step1)

  $("#step-2").click () ->
    processData(step2)

  $("#random").click () ->
    for datum in start
      state = datum.id
      random_risk_index = Math.floor(Math.random() * 4)
      risks = ["very_high", "high", "moderate", "low", "none"]
      risk = risks[random_risk_index]
      console.log risk
      console.log state
      d3.select("##{state}").transition()
        .style("fill", riskColors[risk])
    
