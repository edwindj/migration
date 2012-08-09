fs = require 'fs'

compress = (f) ->
	geom = require './' + f

	coords = (g.geometry.coordinates for g in geom.features)

	round = (coords) ->
		if coords[0].length?
			round(c) for c in coords
		else
			coords.forEach (e,i,a) ->
				a[i] = Math.round(e)


	round(coords)
	fs.writeFile f + '.json', JSON.stringify(geom)

compress 'gemeenten'
#compress f for f in ['gemeenten','wijken','buurten']