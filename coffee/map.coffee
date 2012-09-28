class MapView extends d3View
	parent: null
	svg: null
	
	initialize: (parent = "body") ->
		super(parent)
		@svg = d3.select(parent).append("svg")
		@setElement(@svg.node())
		
		@svg.append("g")
		   .attr("class", "regions Blues")

	resize: (w = @$el.width(), h = @$el.height()) ->
		@svg
		  .attr("width", w)
		  .attr("height", h)
	
	render: (features, dat) ->
		return this if not features
		regions = @svg.select("g.regions")
		regions.selectAll("path")
		   .data(features)
		   .enter().append("path").attr("class", if dat then quantize else null)
           .attr("d", path)
           .attr("title", (d) -> d.properties.name)
           #.attr("id", (d)-> d.properties.id)
           #.on("mouseenter", highlight)
		return this

@MapView = MapView