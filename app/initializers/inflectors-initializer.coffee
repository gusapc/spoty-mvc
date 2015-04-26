`import Ember from 'ember'`

InflectorInitializer = 
	name: 'inflections'
	initialize: ->
		inflector = Ember.Inflector.inflector
		inflector.irregular 'cancion', 'canciones'
		
`export default InflectorInitializer`