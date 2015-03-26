`import Ember from 'ember'`

CancionController = Ember.Controller.extend
	needs: 'canciones'
	isEditing: false
	
	currentId: Ember.computed.alias 'controllers.canciones.currentId'
	text: (->
		if @get('isEditing') then 'Guardar' else 'Editar'
	).property('isEditing')
	
	actions:
		eliminarCancion: ->
			currentId = @get 'currentId'
			@set('currentId', --currentId) if @get('id') + 1 == currentId
			@get('model').destroyRecord()
			
		editarCancion: ->
			if @get 'isEditing'
				@get('model').save()
				@set('isEditing', false)
			else
				@set('isEditing', true)
				

`export default CancionController`