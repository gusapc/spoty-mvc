`import Ember from 'ember'`

CancionesController = Ember.Controller.extend
	nombreCancion: ''
	nombreArtista: ''
	currentId: 1
	
	tituloVacio: Ember.computed.empty('nombreCancion')
	artistaVacio: Ember.computed.empty('nombreArtista')
	
	cancionValida: (->
		!@get('tituloVacio') && !@get('artistaVacio')
	).property('tituloVacio', 'artistaVacio')
	
	actions:
		crearCancion: ->
			return if !@get 'cancionValida'
			
			currentId = @get 'currentId'
			cancion = @store.createRecord 'cancion', 
				id: currentId
				titulo: @get('nombreCancion')
				artista: @get('nombreArtista')
				
			cancion.save()
			
			@setProperties
				currentId: ++currentId
				nombreArtista: ''
				nombreCancion: ''

`export default CancionesController`