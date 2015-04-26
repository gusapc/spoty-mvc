`import Ember from 'ember'`

CancionesController = Ember.Controller.extend
	nombreCancion: ''
	nombreArtista: ''
	
	tituloVacio: Ember.computed.empty('nombreCancion')
	artistaVacio: Ember.computed.empty('nombreArtista')
	
	cancionValida: (->
		!@get('tituloVacio') && !@get('artistaVacio')
	).property('tituloVacio', 'artistaVacio')
	
	actions:
		crearCancion: ->
			return if !@get 'cancionValida'
			
			cancion = @store.createRecord 'cancion', 
				nombre: @get('nombreCancion')
				artista: @get('nombreArtista')
				
			cancion.save()
			
			@setProperties
				nombreArtista: ''
				nombreCancion: ''

`export default CancionesController`