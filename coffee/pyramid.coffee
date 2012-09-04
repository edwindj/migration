### Population pyramid
###

pyramid = () ->
	width = 800
	height = 600
	margin = {top: 0, bottom: 0, left:0, right:0}
	xScale = d3.scale.linear()
	yScale = d3.scale.linear()

	pyramid = (selection) ->
		rescale()
		selection.each((d,i) ->
			g = d3.select(this)

			bars = g.selectAll("rect.bar").data(d)
			bars.enter().append("rect")
				.attr("class", "bar")
				.attr("width", (d) -> xScale d.count)
				.attr("y", (d) -> yScale d.ageGroup)
				.attr("height", (_,i) -> "#{i}%")
			return
		)

	rescale = () ->
		xScale.range([margin.left, width - margin.right])
		yScale.range([height - margin.bottom, margin.top])
		pyramid	

	pyramid.width= (_) ->
		if _
			width = _
			pyramid
		else width

	pyramid.height= (_) ->
		if _
			height = _
			pyramid
		else height

	pyramid.margin= (_) ->
		if _
			margin = _
			pyramid
		else margin
	
	pyramid