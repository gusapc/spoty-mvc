`import Ember from 'ember'`

CancionesRoute = Ember.Route.extend
	model: ->
		@store.find('cancion')
		
`export default CancionesRoute`